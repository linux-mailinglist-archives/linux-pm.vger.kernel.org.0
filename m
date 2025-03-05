Return-Path: <linux-pm+bounces-23461-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E03DBA4F68C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 06:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC0F16E875
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 05:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E12B1DDA0C;
	Wed,  5 Mar 2025 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i5am8EVA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449071C878E;
	Wed,  5 Mar 2025 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741152628; cv=none; b=IWKkxfLPYpj0Fug7uRrNUFAUVS+yQXkTmMlfhPpzVQFTRlzD/NCm377VVr5wPd+sW98ILnhLoagfQUFKzYQkBgGy32JT601LKnQHWDe8J33TVNS6Z568sOnVbLYmsukW8Vufi3LPZrmFc/PH/AO5uwk/P4EFhO9R15k2+9EwMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741152628; c=relaxed/simple;
	bh=Lcm7BEg7Tas04TY7QecAPfuKado1G7il/9aZYqJZ29A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hu1oRk/++FDOmp1Br13kUyEfYENcaRiXaryynoKycEmWKruHSTINZUHQRSAfQqPR8tVG13T64KhXtNEBADY1h8FYdkAQ5XFklUgxTZ3Rfm8FLl+iJ6EEcVEqn1K81VZgvuSojPn8RWsPp3MA8r7lQM1K7DdNTgrUWEA4Nqghsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i5am8EVA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741152619; x=1741757419; i=w_armin@gmx.de;
	bh=ntDKQTzh/orsND8IzvQjep/XVQ0n4zvMoy76hxbPS08=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i5am8EVA/kq76SIqFtxXZbQDyiN22uW05D+kmHaVUpd9jRqIMb4d/8IJzf2AfwjP
	 JJmbrRTs50iOKrYF/hpkH+2xyTAzBzgfLMS9Q4kuuoZO1FEu02D8G+MaBcEc1BQos
	 OLA/TSfcTG0IOVNYIiXoZCP9AzE4GZIfa7dNCimuFUh8xujB+yur38vvB02ETSMtN
	 RLYlEUB2ZNpyaA/wIInlh0LsolEChXvQ9w2pfiH6cJQJA4cErebG5oeUjxOQ/EeIg
	 r4qadfkk5/AcS++BtloUEw3F25yyGjqlG4Ok2EAzpnxNhGWRmLOjRmB9mvD7VEHlQ
	 ryIj466u4Udk0ekF7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9Wys-1tt1G30zLA-003siv; Wed, 05 Mar 2025 06:30:19 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	sre@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: dell-ddv: Fix temperature calculation
Date: Wed,  5 Mar 2025 06:30:07 +0100
Message-Id: <20250305053009.378609-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305053009.378609-1-W_Armin@gmx.de>
References: <20250305053009.378609-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XcxrfxHs1Oy+ILI2Dcmc+DBRf9eCC+UysHwLJi+zq5z1+fDCG+5
 IB4rTu/vFdT3uighBcs9MWalFtscjrtVyiuv0dIQLySKIkTvJHhY5G6Rvf9/49Md5DDxYBo
 TWHcRUR5i+LvKi05TksHipQy1oaRNyFTyHdk/ujQiEa7zjQ1cEANzCCu/eAFH7gGT+oj9MW
 JcOmIbmzbLxHQYg8sT3lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RcT3kDLisPg=;mKyW6oz0L1ph9Hk7I61bOJOfvEX
 tM9sbZdUowsMpaekWrlm4TzXOX/G0GtiwmRG9zJpy7YPYm7GPopaC0257SU2AnfzANsGfdIcV
 VfMqlWY/lt1IHknwBB7BbSS3czufTOqaSwbRAk9A5xqwY6iNRNRQXNC4SfHB9tRY0QnoIssJJ
 9H9Gr7pRvWbAeiifMsQ5rl7Ybv45iUuVMi0xW21irKQ2DvfWe6y7hgW3PUAASzZYjDiUNOzlI
 EFDU9tL9RmCsTHZyr23zpYmPD8kmInyYE4z/lnC8iUeXSJbuMrJYMCWl+t+OlMQbxdqA5qTUQ
 dk2C3j46gD42vID7IR3zajGEwDp2gJeXIqva+Y/dValLzJxV6P8S/HZD03Nuwep0Pi4UepmNj
 FvkKWhWuq9HWGGau/rbeaYz5+/IyGCWUZObdhZKX7HLX6pKNnUsLzrfqPgIyuhtJRBNNSYp6M
 eggViuhWxEndz3dA2DFoblD0fWrvrRjOZU6LsyrMN8C+Wn3JFJ0cZMZbZ/LucFiZDHH3yjHjl
 +UlHR4V1b75IYWmY+McNxWtH1/7e/0CJHSJQCaQirFxMqvyhhvF7fscHMzyKgIzck0K/mg2cU
 MZdTWix0ulGE2L5ThSOqwT52y20ltj3dSibJL35PP7lacKcvhUBMgtlwWLZy8N5MQlD6nCicx
 7tGrG2U8qqgKKusBVCugXM26/ST9XckjQRBm5RZWxv8WxLXtgWf/hZc4IvrqpiFZBiIYxePA9
 4lxAE1l18zSMWttX2+hjiHeCWW+6y7IRNqLmwRzBNLNu6stQAs/kSVMBW1YexGLFr36TI8TUd
 HIPxw3dCmhin0OkuKa8p4H+sVkv6CKCECjrB/g/J++VYiB//okCXeZMwiM9So5jAHqaMfGn10
 dpUsLBd2iSTE9Ndo46zARwSqsvJWgQW0kLs7/KIYi6nNYOw/hPEt9coBPp4/ceuD8tcMo3U5I
 uv5r3rDhamI+clEa1tJYpsjH+eUlGwY4PTAyPjs6y/lMnsSvy/NsuSzeFHU+qxbdf5RiSVoEF
 BlYHtw8g9SAPJgUgb3TZ7f9QyG1BCQbRS4diBAq7di8+Czh9cXtKBtX/tELLdtqcxqNvM7UC8
 /rsrzVhvyyQ9mdZowq5ezWC9tJ/oSZNgM4lfFK3tnhetlqyYuWuwGen+nNsYGUJFG1t92tETN
 iAug8Zfvegca8WimtWdSNsP0oLaJuTtvxWLy25JKiYDgoBlGDK7hPkgheUOwJMNPDV6KrW5Ow
 y/i1XBM200+ZytXPYHoFi6RQc0F1KEJiKDuHHHJe+Pb408rxMRiR6h8CuatT9G+7DCVlJwol/
 gm4dWJlUY24hpz+AT0wfJdS9sB1aW3fP6ZenW7rODbnHrfGDrtXZPPVflnL8cqO4q1+lwLidx
 5c6PcC//LqQ5XWvEaNLhvnscOLUwlGWCvlr5wLP6YTlf43uNupfOzzgH80

On the Dell Inspiron 3505 the battery temperature is always
0.1 degrees larger than the temperature show inside the OEM
application.

Emulate this behaviour to avoid showing strange looking values
like 29.1 degrees.

Fixes: 0331b1b0ba653 ("platform/x86: dell-ddv: Fix temperature scaling")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index e75cd6e1efe6..ab5f7d3ab824 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -665,8 +665,10 @@ static ssize_t temp_show(struct device *dev, struct d=
evice_attribute *attr, char
 	if (ret < 0)
 		return ret;

-	/* Use 2731 instead of 2731.5 to avoid unnecessary rounding */
-	return sysfs_emit(buf, "%d\n", value - 2731);
+	/* Use 2732 instead of 2731.5 to avoid unnecessary rounding and to emula=
te
+	 * the behaviour of the OEM application which seems to round down the re=
sult.
+	 */
+	return sysfs_emit(buf, "%d\n", value - 2732);
 }

 static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
=2D-
2.39.5


