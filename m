Return-Path: <linux-pm+bounces-18156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24B9DA95B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0292B23F09
	for <lists+linux-pm@lfdr.de>; Wed, 27 Nov 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013481FCFC6;
	Wed, 27 Nov 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjlTojNI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FFF5B1FB
	for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715582; cv=none; b=dPuEUA7gS/9VC2l6Y7GIbDrp+CTjQJ9Y1xJ6wC/gmxcLsOAIuqG/XVokbo6z/VoWd0HEi8Aa6bwQrttMYe/QWeYgZM54yHeu38BSEbOAQldYN24TScio11lKA7Yak5z64gCMkJ2J2yxj82p5u3zkB7ubx7MXhnVjS7Cdv3InEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715582; c=relaxed/simple;
	bh=4Cw79OlSsmeWvc5FvG9UqEOqdIJZu1hBHoIJTBQ2WY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWaDlVGu4PrN8Pf1fbo94K697+NYasVijy9xea4ZsSyJBpgqoB+y7rAR0VRAcPAviIEfuEATK9SFhkjiQ0eUUNtB7cOMF05feAo+kPAyjd/q90/RpHpBg7ZYQRUslzjlEjtvA03jw1z3tiPVkePX5g6oAHKyXmswilYEl1wXyVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjlTojNI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de035ea13so3694455e87.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Nov 2024 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732715579; x=1733320379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4TAQTX45KjbD07bV+ebD3Bm2L1TSD7dI4Xlh2Tdxk8=;
        b=jjlTojNIO+qNFCKQKQSqC/qDcfYbUDzhnbbmLIs5+NDriUQn5HY4m9ILS1SKSlqBvE
         qH2m8BHLwzfzVH7JFBcClX08/3LfpwnbdoOK4YlFGXgUHfdFE6oYVgmrGYmbk6kdvrTb
         po3gk8fYwpPUScdISpxnJpNmxhJuBfLLssN9ighsBtJHIv4ZaDxHk4WiQr2Me0vD2NXq
         ZQwqejJ3C2soZDSerXVr0fE2z18fAoC4JPgplL6M2P59fiToSLkzsc8kqCsP0u2F2b78
         Dj2D4FoP90w4TzJpSB2p9UA9jK9+kHKs8n4ToAUsCm8WZ6fvrtOu05tBhLdUaEyg34h4
         ZYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715579; x=1733320379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4TAQTX45KjbD07bV+ebD3Bm2L1TSD7dI4Xlh2Tdxk8=;
        b=cz/AOVC0kQYrnN9SXcURuDH8m60l/3C+74ZzQMmmnI72p56sBFDpuzUtwA2OBtQUQR
         4TAW7OaW5ffDk7q09P3mLw0MQdu4gj9s+zOkykh3X2hDAHawbjlOSravZURYNSk1bfB6
         EuyH/33tv/SAwEqj4jU+vhFuJxiL2J9RJ0BdugZghZd+WWFh8vW1oAJv3xrL01iDvBuI
         04EAYXZ7tIkCKJHh477gsQniYkuEroAl4cwUAb81/BiSvf5Z05S3hruZ/X+R6TbAH1QQ
         +bO/NJy4ng+cHPe63gW6jeYdhu17NQKgScyHitFvQ9jnKHwIBD7UqPOiPGQZN8giXKrx
         pfDw==
X-Forwarded-Encrypted: i=1; AJvYcCUoItY1vjhozXtu1dAObArs3bdJoZS+yv3m/BCp0WfMPg0650IzFMjwvW3Wb0qRMaB4iBb0dzcknQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVl5HRhnUwDEu+OPvSSTJ0j2pLpWANPOqTH/4GA8xrPDY96qIU
	ACPDSLeN8ZmRexiasoijGdizMm1aKvh6IEA+e0EqkAzGylnSbzFb6L8dpoP+gU4=
X-Gm-Gg: ASbGncua2zncaKCk5esv+Uo3tpulW7dSeXuJnpI0Cbgt1iQ9LZ4EZd0TaCplT3tJA1n
	W2XhI7+LNtFzryZu4ktink+0d7YpChnvCkoHQglq85W9rkOzBwZaixgXdUwr5V+xWYzwkVf9lGI
	Irtm2aVkaXB1lIn97/ZO2undf7fi6XMlzrM/bSluXo7BtGST8NQG7AICaPrcUQEpgzdvZb828YV
	LU/+RKE0ZkEBLqxS5q1rWPA20BOSDYYEOMkrxKgNgA7KLQpXoZlq+pShRQnZ9dXGdATaNpUeOMx
	EkffN8SpGwOfLXmyluNGDXJMBroIdg==
X-Google-Smtp-Source: AGHT+IGYADuFA26pMJrHLMzO1jvXPbYIAXbhv0Ob6Xw8c8Ir7HGjlq9gt3AUm5PCW3k8fSZi76WMOQ==
X-Received: by 2002:a05:6512:3c89:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53df00c5ebamr1944019e87.4.1732715579361;
        Wed, 27 Nov 2024 05:52:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24518d7sm2314321e87.80.2024.11.27.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:52:59 -0800 (PST)
Date: Wed, 27 Nov 2024 15:52:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Enable Bluetooth on qcs6490-rb3gen2 board
Message-ID: <sntzr75d3by7ignomcrcsmzqdtbikonyuwj5niccuenoxndaxb@vhu5en6hetqx>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>

On Wed, Nov 27, 2024 at 05:21:05PM +0530, Janaki Ramaiah Thota wrote:
> - Patch 1/2 enable WCN6750 Bluetooth node for qcs6490-rb3gen2 board 
>   along with onchip PMU.
> - Patch 2/2 add qcom,wcn6750-pmu bindings.

- Bindings come before DT changes
- Driver changes should be separate, one patch per subtree (so one for
  BT, one for pwrseq).

> 
> Janaki Ramaiah Thota (2):
>   arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
>   regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750
> 
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 174 +++++++++++++++++-
>  drivers/bluetooth/hci_qca.c                   |   2 +-
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>  4 files changed, 223 insertions(+), 2 deletions(-)
> 
> -- 

-- 
With best wishes
Dmitry

