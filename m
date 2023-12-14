Return-Path: <linux-pm+bounces-1140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456E812C2B
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 10:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17582827C4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Dec 2023 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBF335887;
	Thu, 14 Dec 2023 09:50:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDA81FDE;
	Thu, 14 Dec 2023 01:50:09 -0800 (PST)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5908b15f43eso716882eaf.1;
        Thu, 14 Dec 2023 01:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547409; x=1703152209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7IcPRb+X4qnuTs0aHDHBpi/NcRx3U1FPPLkX97/vT0=;
        b=YbeMpdvl+8fpL4KZeR71OUAvsadM6ll1fnobE4c5xVpaPyVx9BsD5CmWjYjWkJcB6V
         O08FJRtm7JDLwwxSSc5dO2yF/jlyK7fn+b/CziPgiRRwMOAOuiCTWjUN5/vLt8aIchf2
         6y0E3f3jbjdnkN303TYIk0np5z4pU5X8YwJjo59rnSH6jH048OHI0aGiXmrBdOwG8FFR
         Tlsza9GJeow+046NbPZqRejENW9OMr+TdtuHQYDvnqahSGCSzxZJ/le2rqvFVXyRjpxh
         rO4Jyk2iYEt/jnL8p9eZ5JG7P6FfL3VmLxSwp9zdUfGdvaZV/mzDW3Fp/zXsxHR7Ieoc
         NrFw==
X-Gm-Message-State: AOJu0YxtYeyXb/ibQEhdwSikq128CVRX7G6FUOTWO4DWR+Wfi2EC5hZc
	/6cOquHRy8lGdp/8tCRqeiAITxhbAZ0NTVET61c=
X-Google-Smtp-Source: AGHT+IGjjfZZyhF8aBrc8arga5Q1x2NL23YNg0eLq9/u1h3fJzX/pm+FRQC/QVJZ6OdzoCYLjk4lm5pADQbrZgiKE0o=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr17719939oab.2.1702547408842; Thu, 14
 Dec 2023 01:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Dec 2023 10:49:56 +0100
Message-ID: <CAJZ5v0gh0KSogBqtkq6GmK4pZ7iDc2FELr3=P55ifBish_NeSw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] PM: QoS: Rename freq to range constraint
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rafael@kernel.org, caleb.connolly@linaro.org, lina.iyer@linaro.org, 
	lukasz.luba@arm.com, quic_manafm@quicinc.com, quic_priyjain@quicinc.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 6:58=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The frequency pm_qos relies on a couple of values, the min and max
> frequencies. However more pm_qos will be added with the same logic of
> a couple of min and max. Instead of writing new set of constraints as
> well as type, etc... let's rename freq_* to a more generic name
> range_*
>
> That way, new qos range based can be added easily.
>
> No functional changes intended.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

[cut]

> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -77,25 +77,26 @@ struct pm_qos_flags {
>  #define FREQ_QOS_MIN_DEFAULT_VALUE     0
>  #define FREQ_QOS_MAX_DEFAULT_VALUE     S32_MAX
>
> -enum freq_qos_req_type {
> -       FREQ_QOS_MIN =3D 1,
> +enum range_qos_req_type {
> +       RANGE_QOS_MIN =3D 1,
> +       RANGE_QOS_MAX,
> +       FREQ_QOS_MIN,
>         FREQ_QOS_MAX,
>  };

I'd rather do:

+enum range_qos_req_type {
+       RANGE_QOS_MIN =3D 1
+       RANGE_QOS_MAX,
};

+#define FREQ_QOS_MIN     RANGE_QOS_MIN
+#define FREQ_QOS_MAX     RANGE_QOS_MAX

and they would map exactly.

