Return-Path: <linux-pm+bounces-31425-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F42B11FDA
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB431CC2CE6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jul 2025 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761902459CF;
	Fri, 25 Jul 2025 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3GNcyl+V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541F322DA1F
	for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452889; cv=none; b=fGEbH0RO4hPlk0xN/XIC9NGLHVAwdE8GGhqWEQY/Gj2cEP2TpdV/xkF7bER+bZjypTbAMePYxOY0TKDYKd8gNvgUS2tc1A8C6gfRErvaToWIWx8rS/vL9LvIVx26yf8oWf4eAdFBAsMdx2EuCownkMQsj/YE9h2HQzIO8ICQSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452889; c=relaxed/simple;
	bh=rNyAWlp56eBFvy36oX5YiZlPyIt11W/cxbD2Iyf2S4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PZn+Z7AWO/DIbI9Q0X44j2ETZjgCKiap+JTXwb2G4OXe5379y1XrB+wm4egpohxLjZNtMe3N+9yFyO7/aZgFZNmuG7YQTufof1n3ijp2+2hVlRk+kYVwe4HR8evH+3VYDpngRBNurAiizBOC8S7KcUUIiWEDe9wff74i6LSHZhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3GNcyl+V; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so3743988a12.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2025 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753452886; x=1754057686; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSkJyTrv6R3uiwv3q2J4zn3hDj1JQ7Rtyl+OeDRudNc=;
        b=3GNcyl+VN56MLlLZZiFVdso3FYTMvxLqn0YicT4yjc3jDsdFduc6k8L2aJz+z7EMyB
         MwmZZxlrU27kgawqJRkZm2zoQP2golw0YdBQEdxJg3OpVk1uIXLgbBiO2YEe9ssCeyfq
         NEE3TiphHbKz1lK+XfH2G1qBUvZKPPaJv/znEj++VkWiLz9kiBcbgwmdKXKc/juZaz6n
         UkHw63EKc8v0nhrOsyDsAZvXu1g8aeI0CtC6L22yQcvO5DjQdju5F0hof5CO4JJFhDKR
         1va/awzeHy9uwa5YGsdaj0I5nvvekY+MC7BvqIZtc30xXJ7j4vpvZDgX2T5xHDb0Qfib
         /0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753452886; x=1754057686;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iSkJyTrv6R3uiwv3q2J4zn3hDj1JQ7Rtyl+OeDRudNc=;
        b=L4VVjizD8z2G+nATjOS50LcD0R59fv9a8YnYb1KiKvwSuO51GLELI7JhMVnmSo3gqp
         rLd2LUFf9JQ3JCW6ZB3EbvFWHihGjUH/Oqf2XHyTMNz+FB4lxQzOc/bMlT44R9RrQb4y
         /2QYJwOTnnvFiSeNXS51FmFLG6Y01wyuuyQwnzRxKUku8NxYi6Pyomq3xXLiEFLMfMxj
         NtAzqEUsLXFER+Inp7VG/wJAnwRDMRyjbamXm1xsLNuDf3Ze/IdCzYRJmjdJd8R30dFg
         nAD+QO3W10KQRo4hdWldzj+7dragwCeVF7c76QBGQbqdfD1gP/bDM9wF8jOZD63OEa+C
         QZZg==
X-Forwarded-Encrypted: i=1; AJvYcCUZp/t400cQEzcAcRD9STZmDZ8uzz9iZ3/E9BU5pkPWEZiv1lsgODUcEdPqxXoOhVbzghgSKamh3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZ5XZtzedyhAr0z9YeoGKR3UMs7CawzGrkUsK8UvdkArUUflB
	QhWib5N/ubtIzVYDXP/zw0m3OEVO99tmzyXdQHQ6XdVT7rcXzRuegpHuziPkVsIn27k=
X-Gm-Gg: ASbGncsse6wpHKtx7E7rJaSkT5437Di8RIwvUPrHMivQ869dRw7oaXpON2w6svN50Wz
	J0ia4lWN9DejpFQ6/WRfhaQ4unL6A/5x+kKRJJzU8QDyMdCxMR+3ywgSMtCtztk7b/8fi1FQcQu
	OHODfmQ8wdciK419RWwayZSJrzzePAa6bqTqIg385IGM/QQrPNfO1jgZV+x9HdeyFhe5nnw7f7G
	4bigtzP/8cpNSL2edoDSdePHO04wVI4UOTPwqm9x8Ir4PBPZbtGWxInO8BBkuUpIWvujtvrGdlN
	+O7w1tL/UgjQMIrSusNpBH4MO43aAZfWizsQALRHp9OPV8Uw90nj+eFVophyOF98MlojR38esED
	qRtbHi+fItVve+udzpLO0omWqhrLUNv9Lq4cTXAmNmaFJQKDwn+EDgAZXuRQzcJmaaq8=
X-Google-Smtp-Source: AGHT+IGz463msOz8qJcurxvgKtRb5VKMVkS2t8llkd59+2lECxEEVtdl6gBW3cfbqM7OYO38KYCWFg==
X-Received: by 2002:a05:6402:3595:b0:604:e440:1d0b with SMTP id 4fb4d7f45d1cf-614f1a88810mr1744941a12.4.1753452885513;
        Fri, 25 Jul 2025 07:14:45 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614d907a40csm1635236a12.15.2025.07.25.07.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 07:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Jul 2025 16:14:44 +0200
Message-Id: <DBL766O111UP.1IBG5Q30DCEQS@fairphone.com>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
 <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH 06/14] dt-bindings: mailbox: qcom-ipcc: document the
 SM7635 Inter-Processor Communication Controller
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Will Deacon"
 <will@kernel.org>, "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel"
 <joro@8bytes.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>, "Robert Marko"
 <robimarko@gmail.com>, "Das Srinagesh" <quic_gurus@quicinc.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Amit Kucheria" <amitk@kernel.org>, "Thara Gopinath"
 <thara.gopinath@gmail.com>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-6-d9cd322eac1b@fairphone.com>

Hi Jassi,

On Wed Jun 25, 2025 at 11:23 AM CEST, Luca Weiss wrote:
> Document the Inter-Processor Communication Controller on the SM7635 Platf=
orm.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

I see you picked up this patch[0], but "qcom,sm7635-ipcc" should be
dropped. Only "qcom,milos-ipcc" from v2 should land.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3D872798f61d8bfea857e54aa17baa7b0d3ee24b65

Regards
Luca

> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/D=
ocumentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index f69c0ec5d19d3dd726a42d86f8a77433267fdf28..6e86ec36a82254ebd73c3067d=
e495795c36c6bee 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -34,6 +34,7 @@ properties:
>            - qcom,sdx75-ipcc
>            - qcom,sm6350-ipcc
>            - qcom,sm6375-ipcc
> +          - qcom,sm7635-ipcc
>            - qcom,sm8250-ipcc
>            - qcom,sm8350-ipcc
>            - qcom,sm8450-ipcc


