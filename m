Return-Path: <linux-pm+bounces-40632-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC3D10A41
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 06:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E5993010D58
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jan 2026 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F430F7E8;
	Mon, 12 Jan 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXZJ04N3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40422AE65
	for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2026 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768196306; cv=none; b=svISHD753mpA+yAmuG3A/v7HHRNpqs1puCtw3jcRvNVDYMcv/F7xPWY7+d+N1Lz61l8M29SIwvePI6tx7rvrNAdx3w62Iz/fEeOTeUnu650Na93g+QEtcjlK/vojUcY9nJ8kCTvCinkRLLvZ8aOIPEwxA3JQ8u0Uu9dS2WeRG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768196306; c=relaxed/simple;
	bh=yRekZoc+hraDDxFzS3TNOg5nB0DOTMe4YjjIKUIFxxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlwpKvt3nSoXV+KyIPKTXk2zT+S1o0fpMB4+yUKpeN0UsnjD8gcoBFkA8SItO20kj0TW+852HHt3S8ZzD0CGaMFihUAK0uKkH2uKF13dQKflD7NFfxtgayfITZfGItZRcVXvcKotCJpEGskWSRmHoPmX8jojSUaxK4wv0iEbiaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXZJ04N3; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8bb6a27d3edso639659485a.3
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2026 21:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768196304; x=1768801104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlmf1lLjMUIK5sK0i0csfi0RpQ6LtYlvJ96pMKLiEAY=;
        b=YXZJ04N3sN44R5yvgfzvpUEvpVtpf+95dScdOol9n3isGPeYFECCZsboCnD3Z+DtWr
         nLGAxta6V48yz+UuO4l4jJniuxccnatG+3yOKOmnjiRU7XSLnDTju9ny3z3jzB0sOAxA
         EgC6NLAsPBrCIPBgc/fSIBf/yoTpr4UV9P+ct0eN9abjT8dKosPJBJAHFZ6wi82G17RF
         2X24pEWTzH2xpYMhtdZdGfinmiOqIelAgUBB9ZbW2tFsLNJR9zqaGmO74UWThUGLTPWN
         BICuOh84awzJXm0V2Dpk9FjpfhMYvL6NWBFga+kegu7mcbvtZoN6M88ZwIydlcawcNnP
         evUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768196304; x=1768801104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nlmf1lLjMUIK5sK0i0csfi0RpQ6LtYlvJ96pMKLiEAY=;
        b=SdVaUbXx7NF0nO0py/AfCzPPUHGwmUGV+RtX0s9CHe3oom6dVbWdBr4CmxBZii1Eoh
         rfggwm9Rp3Kjw1a58RRTmpB4dBPByi+qxiIpbIbXASexEEoHgZnSgvVAzZKLEGy5LqMR
         856vpZE7Wm9iAo/3CN5k1m9ARJhgw7hKaPlHkaaqMZEXZ4NJzKKIebpsACm+8MnyOX0U
         xBRCwFW/ibn0NlbrKTZ81UcAjQtCw1u4ls0uls4BQlyr8cl/Oer2u2yFBO7NGCMDQp9C
         6rzNzpi+r7R/zZ/b54lSGvF6ID9V/VVk/oGpH+WV7YmIDbF1nzljf/9yCBqmOWnsgbN1
         14pw==
X-Forwarded-Encrypted: i=1; AJvYcCWu6TrvuW/bUFWvP1kPAQomhXRxR6KUdjf+YO5A9POEEGuKzKEz+QdCvG4iuvV9SOrHBs8HeudPVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKv/0zXYUTEOJPcR251sZpjH3K/Pd3kEIKltnRfpndNxL/ssZs
	MINq6TdmouXGBoKrnLz/D2A6c7FoAvmfvLn/DqkB3wuQ3JguMtR/RP0mWRy9r/7j+2frQN6+sNB
	dQYmstjvnzAqoLn8VbttlTQmJ/PsasjM=
X-Gm-Gg: AY/fxX47e10xNSQ5s+VUGyFAmJG6rWcWWq2jPoAYguNd2TvpsYXDrPa3VEhw56oAomC
	pxgRy6gKaq++aMCbbTycNcaYV7xIbJvp4V/hdSI9zH6P8AQVXDUVynuIp8KUCSbQNO9SHR7yXY5
	DgZfowhJLfAViCj/5hXeQxTLQuaG2Q5C33GhZjFzOECyhESkcgGtAsCWjXqUmHBEv90rbg0Whvt
	Qd//ba84xZnCXTwVXuTTM7ztNenRzQ1b7D9hsd8kmzJj++Oafj+KK6C4ETcGXxc678LHFRT
X-Google-Smtp-Source: AGHT+IGm1cj36Z4F8GYMdEb37dMze/9eBaWNEq+Qz9UYro6CbdtXCyrdR5y71bA9IS7frHu+hvj/e0JQdBCbpxXV18E=
X-Received: by 2002:ac8:580f:0:b0:4ee:1db1:a60f with SMTP id
 d75a77b69052e-4ffb47d6537mr264143061cf.16.1768196303955; Sun, 11 Jan 2026
 21:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112053047.3489-1-xuewen.yan@unisoc.com>
In-Reply-To: <20260112053047.3489-1-xuewen.yan@unisoc.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 12 Jan 2026 13:38:11 +0800
X-Gm-Features: AZwV_Qhe5AnPVsttnCDXHhxUBNDwdqSTh7w21OWRU4_7DTa3faJ1T0wntgIfoSc
Message-ID: <CAB8ipk-UjGy_8Br=m0KpwmfG23_wE8DY_39PD+XubJe6ULhQvQ@mail.gmail.com>
Subject: Re: [RFC PATCH] thermal: power_allocator: Ignore cutoff when integral
 is less than zero
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org, 
	rui.zhang@intel.com, ke.wang@unisoc.com, jeson.gao@unisoc.com, 
	di.shen@unisoc.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 1:31=E2=80=AFPM Xuewen Yan <xuewen.yan@unisoc.com> =
wrote:
>
> From: Jeson Gao <jeson.gao@unisoc.com>
>
> The cutoff means threshold below which the error is no longer accumulated=
.
> However, in some scenarios, this may cause performance degradation.
>
> For example:
> the control-temp is 85, the cutoff is 0 or other small value:
>
> If the current temperature frequently exceeds the set temperature,
> the negative integral will continuously accumulate.
> Over an extended period, this will result in a significantly
> large negative integral value, the positive integral can=E2=80=99t build =
up
> because of the cutoff. This makes the power_range very low,
> even if the temperature is already under the control target.
>
> So, if the err_integral is negative, ignore the cutoff to force
> add the positive integral.
>
> Co-developed-by: Di Shen <di.shen@unisoc.com>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  drivers/thermal/gov_power_allocator.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_=
power_allocator.c
> index 0d9f636c80f4..404ae1d75612 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -263,7 +263,8 @@ static u32 pid_controller(struct thermal_zone_device =
*tz,
>          */
>         i =3D mul_frac(tz->tzp->k_i, params->err_integral);
>
> -       if (err < int_to_frac(tz->tzp->integral_cutoff)) {
> +       if (err < int_to_frac(tz->tzp->integral_cutoff) ||
> +           (err > 0 && params->err_integral < 0)) {
>                 s64 i_next =3D i + mul_frac(tz->tzp->k_i, err);
>
>                 if (abs(i_next) < max_power_frac) {
> --
> 2.25.1
>
> ________________________________
>  This email (including its attachments) is intended only for the person o=
r entity to which it is addressed and may contain information that is privi=
leged, confidential or otherwise protected from disclosure. Unauthorized us=
e, dissemination, distribution or copying of this email or the information =
herein or taking any action in reliance on the contents of this email or th=
e information herein, by anyone other than the intended recipient, or an em=
ployee or agent responsible for delivering the message to the intended reci=
pient, is strictly prohibited. If you are not the intended recipient, pleas=
e do not read, copy, use or disclose any part of this e-mail to others. Ple=
ase notify the sender immediately and permanently delete this e-mail and an=
y attachments if you received it in error. Internet communications cannot b=
e guaranteed to be timely, secure, error-free or virus-free. The sender doe=
s not accept liability for any errors or omissions.
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=85=B7=
=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=8F=97=E6=B3=95=E5=
=BE=8B=E4=BF=9D=E6=8A=A4=E4=B8=8D=E5=BE=97=E6=B3=84=E9=9C=B2=EF=BC=8C=E4=BB=
=85=E5=8F=91=E9=80=81=E7=BB=99=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=89=80=E6=8C=87=
=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=E3=80=82=E4=B8=A5=E7=A6=81=E9=
=9D=9E=E7=BB=8F=E6=8E=88=E6=9D=83=E4=BD=BF=E7=94=A8=E3=80=81=E5=AE=A3=E4=BC=
=A0=E3=80=81=E5=8F=91=E5=B8=83=E6=88=96=E5=A4=8D=E5=88=B6=E6=9C=AC=E9=82=AE=
=E4=BB=B6=E6=88=96=E5=85=B6=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E9=9D=9E=E8=
=AF=A5=E7=89=B9=E5=AE=9A=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=8C=E8=AF=B7=E5=8B=
=BF=E9=98=85=E8=AF=BB=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81 =E4=BD=BF=E7=94=
=A8=E6=88=96=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=AE=E4=BB=B6=E7=9A=84=E4=BB=BB=
=E4=BD=95=E5=86=85=E5=AE=B9=E3=80=82=E8=8B=A5=E8=AF=AF=E6=94=B6=E6=9C=AC=E9=
=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=BB=8E=E7=B3=BB=E7=BB=9F=E4=B8=AD=E6=B0=
=B8=E4=B9=85=E6=80=A7=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=
=E6=89=80=E6=9C=89=E9=99=84=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=BB=A5=E5=9B=9E=E5=
=A4=8D=E9=82=AE=E4=BB=B6=E7=9A=84=E6=96=B9=E5=BC=8F=E5=8D=B3=E5=88=BB=E5=91=
=8A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E3=80=82=E6=97=A0=E6=B3=95=E4=BF=9D=
=E8=AF=81=E4=BA=92=E8=81=94=E7=BD=91=E9=80=9A=E4=BF=A1=E5=8F=8A=E6=97=B6=E3=
=80=81=E5=AE=89=E5=85=A8=E3=80=81=E6=97=A0=E8=AF=AF=E6=88=96=E9=98=B2=E6=AF=
=92=E3=80=82=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=AF=B9=E4=BB=BB=E4=BD=95=E9=94=99=
=E6=BC=8F=E5=9D=87=E4=B8=8D=E6=89=BF=E6=8B=85=E8=B4=A3=E4=BB=BB=E3=80=82


My apologies, I missed the disclaimer in the email. I will coordinate
with our IT department to have it removed and will re-send the
message.

BR

