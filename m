Return-Path: <linux-pm+bounces-40631-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0DDD109FC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 06:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DBC9301B83B
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 05:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596ED302CAB;
	Mon, 12 Jan 2026 05:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b="ladLvj7G"
X-Original-To: linux-pm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77FA500953;
	Mon, 12 Jan 2026 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768195929; cv=none; b=reXN4WdpIXIrhyTN4TxzbXKj7HQ6Ndn1W+o3dzodjLbr8VUOQOvfHnOlJpK92LyxFNL97WactUQHjkng7WBnUUEWw73/yApvjzN0Al96b0eL6svGofNNCGiAXVBL9Yx3/JBWQIDb8A7OXf6q/fFZE6Kh95DJxQBV5HTenHQWkEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768195929; c=relaxed/simple;
	bh=5RjAbkPWJsOBlR/52r8NZg6hjiZ6jKfbWiNlTIcNwq8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snmda6AeJ70+LVpxbUgDU9sxMWWha2W+ma5A3F7zG0QnT/repnj6el+tr4IgV13WSsamvRPTiN34+ZLmQCRn3gjfyQJjFj5GFjlm3t4kPOIXA+Iv8en6PCvUye3b+psfnBRpyM/RGOxb3RGzqVg81Kq0bx8MHvX5K2M1Qi4puAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; dkim=pass (2048-bit key) header.d=unisoc.com header.i=@unisoc.com header.b=ladLvj7G; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 60C5W2lY075755;
	Mon, 12 Jan 2026 13:32:02 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 60C5UrS0066744;
	Mon, 12 Jan 2026 13:30:53 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (BJMBX01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4dqLS911G7z2K5bR3;
	Mon, 12 Jan 2026 13:25:29 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Mon, 12 Jan 2026 13:30:51 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <lukasz.luba@arm.com>, <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <rui.zhang@intel.com>
CC: <ke.wang@unisoc.com>, <jeson.gao@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] thermal: power_allocator: Ignore cutoff when integral is less than zero
Date: Mon, 12 Jan 2026 13:30:47 +0800
Message-ID: <20260112053047.3489-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 60C5UrS0066744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unisoc.com;
	s=default; t=1768195867;
	bh=hwqamRrBkv31V84vk3CbYg3EjlRq2+YxVqM5NNgVDiA=;
	h=From:To:CC:Subject:Date;
	b=ladLvj7GxGcqv0vZpXxYCRZqNUTZtDfjm95dQYmwWanzxq9EXXqOC4XR+AxLtVkJU
	 UwEyfbJwViYad9qg7GiHVx6sNzz2I2wtT4gtr1uPNVVUbkhLw608wrcISgL4WZcfxe
	 ifp25JLapxs5teOWNwRF5cB81G/nUCb6Vl2B0DSb8evTMSxwW0bVboN6AyPb+cONge
	 9MYxvxZmGYm8Ctu7JH1iKKmApqq2R8a9YQlCLJCH/RYggC7cb8sB9VCntLxnf6r+eL
	 cc7Wn9TczMoRBd0rsVmKolHvGUc7gWSFN9TfxgM2kniQcYNkrkZp8A3+oIRVHg4PkT
	 xiRc+ANX43wJQ==

From: Jeson Gao <jeson.gao@unisoc.com>

The cutoff means threshold below which the error is no longer accumulated.
However, in some scenarios, this may cause performance degradation.

For example:
the control-temp is 85, the cutoff is 0 or other small value:

If the current temperature frequently exceeds the set temperature,
the negative integral will continuously accumulate.
Over an extended period, this will result in a significantly
large negative integral value, the positive integral can=E2=80=99t build up
because of the cutoff. This makes the power_range very low,
even if the temperature is already under the control target.

So, if the err_integral is negative, ignore the cutoff to force
add the positive integral.

Co-developed-by: Di Shen <di.shen@unisoc.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_po=
wer_allocator.c
index 0d9f636c80f4..404ae1d75612 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -263,7 +263,8 @@ static u32 pid_controller(struct thermal_zone_device *t=
z,
         */
        i =3D mul_frac(tz->tzp->k_i, params->err_integral);

-       if (err < int_to_frac(tz->tzp->integral_cutoff)) {
+       if (err < int_to_frac(tz->tzp->integral_cutoff) ||
+           (err > 0 && params->err_integral < 0)) {
                s64 i_next =3D i + mul_frac(tz->tzp->k_i, err);

                if (abs(i_next) < max_power_frac) {
--
2.25.1

________________________________
 This email (including its attachments) is intended only for the person or =
entity to which it is addressed and may contain information that is privile=
ged, confidential or otherwise protected from disclosure. Unauthorized use,=
 dissemination, distribution or copying of this email or the information he=
rein or taking any action in reliance on the contents of this email or the =
information herein, by anyone other than the intended recipient, or an empl=
oyee or agent responsible for delivering the message to the intended recipi=
ent, is strictly prohibited. If you are not the intended recipient, please =
do not read, copy, use or disclose any part of this e-mail to others. Pleas=
e notify the sender immediately and permanently delete this e-mail and any =
attachments if you received it in error. Internet communications cannot be =
guaranteed to be timely, secure, error-free or virus-free. The sender does =
not accept liability for any errors or omissions.
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=B7=E6=
=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=E5=BE=
=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=BB=85=
=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=E7=
=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=E9=9D=
=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=BC=A0=
=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=AE=E4=
=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=E8=AF=
=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=BF=
=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=A8=
=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=E4=
=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=82=
=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=B8=
=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E6=
=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=A4=
=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=8A=
=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=9D=E8=
=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=E3=80=
=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=AF=92=
=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=99=E6=
=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82

