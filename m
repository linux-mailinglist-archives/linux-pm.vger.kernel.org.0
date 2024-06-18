Return-Path: <linux-pm+bounces-9429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A090CAEC
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 14:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AE129343C
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 12:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A04153582;
	Tue, 18 Jun 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KW1i0k9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435C14D2A5
	for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711773; cv=none; b=dFZYjusgaO1AGDOf/+5kltbbSX6s40sx3aI2IFUezd2Tn68XFDSen+XwMIsgXxPnFEnyNQ++F3+A5iXH2/ePnYy362fm2fkafDSQv7boOs/6X6lIly0FL9EghkvsBS2P3OrrHjhGlbBgWrE5rVjkBi0HEky3QKXd8/bP1TccPG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711773; c=relaxed/simple;
	bh=jpPEB/6YZTPYLy3RYj7LOJsKZCfOADwF3vloVsYeags=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ceQEoYLwn3Du/8mwdPpEsbgYNLUxJse4J/pM5R4ry8Zw2ekDIUaXeFTqXnBPSreSy1LynyJHSv02srlYyUb3qnEHbTWgxd99l4AUDFjcTOW/+PDbyeuKzjiykDNopi4By+HLyGJtmqePPcHya7aSd2BIr1bFxGhFtUa6Ll4fuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KW1i0k9q; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cc148159dso1274854e87.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2024 04:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718711768; x=1719316568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mq75lZPvciVQwZ7mi6K5o2q0ASdayZBfX3qCcW8QAuE=;
        b=KW1i0k9qj0DskKaCd1uV1Dlm3Ignkxrap9uKQr1wHBUc6iiPcmYL4bQAjj1qoJJmk0
         c6F4rsmFO2rpCbPJimWUuw3b/2paE4eA1VjbNXnPDQtPl4UwRx8hltyorbVoKUQsJR0F
         F5N3l6JCZdON/lrLnQnFxr0O+AuQGi8nW6B9hLXQ6JGfv+hcEBf2OZMcsrJEc17WwShE
         VhQOy856Ii6Jj0/DukJJ1KLdp3cD2uqKrRQKt6tJwm9VfyxAihYjcScdd3RsBApNUT1Y
         kEjNdXJ7LfXm4prHCAVvJRbmRTzOuEaRYWPLFINadyXml5OMfkCXffUwg0hqUf08wYw+
         5Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718711768; x=1719316568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq75lZPvciVQwZ7mi6K5o2q0ASdayZBfX3qCcW8QAuE=;
        b=aMwSzvvvFsdg4tipjr5ehl8FBVCfXh3BsOZLjLnnIw7PkpIjVA/rcNOlorW7vAPTQe
         wfCfSWzTP9We3HKeadO3xpnS7RsQzW9dtvYFpZJTw30AllUF+BaOnpPURE4/QN8zX68o
         SVq9e83ed++sil6x2MVF9OU3fRuU4Q1D3kc9KUXsg+n1vANc6bjW4yf0OQ5VNFvKwT/H
         v9u1p/SXpVXkDQniSk9/7xqDO28QFwO5F4YIFVvyo8WBMrXvwb4SMJP1BtRh8Bzr5Q1x
         oF1UN6Suws7I83l5mZbnOlfv183XSqT86fdQMrnJ0YcICy0yg3n8OU8euBGHaAmTOxo3
         lSoA==
X-Gm-Message-State: AOJu0YxNo7WWA60fexBV3HWm619iXSjZTmKKaDEpX0JjfQibr822e5zC
	pNVjXpSui8II0HZJXlarJkq7nb2yc2U81LDHypGWj/BAL/BURruFPgdD9XbZB5U=
X-Google-Smtp-Source: AGHT+IEYh8t5Lf/IT2gzYEj9aUFut5HJwk0C+UH8HgqmpV5pG3oPCZTtmSV1TDxS2pKMtIogxvp+lQ==
X-Received: by 2002:a05:6512:3b93:b0:52c:8206:b986 with SMTP id 2adb3069b0e04-52cb621b577mr6055207e87.56.1718711767941;
        Tue, 18 Jun 2024 04:56:07 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28870f5sm1487968e87.249.2024.06.18.04.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 04:56:07 -0700 (PDT)
Message-ID: <c807a7c6-ac17-454d-9a99-1a221038774e@linaro.org>
Date: Tue, 18 Jun 2024 13:56:04 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/6] arm64: dts: qcom: c630: Add Embedded Controller
 node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nikita Travkin <nikita@trvn.ru>
References: <20240614-yoga-ec-driver-v7-0-9f0b9b40ae76@linaro.org>
 <20240614-yoga-ec-driver-v7-6-9f0b9b40ae76@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240614-yoga-ec-driver-v7-6-9f0b9b40ae76@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/14/24 01:43, Dmitry Baryshkov wrote:
> From: Bjorn Andersson <andersson@kernel.org>
> 
> The Embedded Controller in the Lenovo Yoga C630 is accessible on &i2c1
> and provides battery and adapter status, as well as altmode
> notifications for the second USB Type-C port.
> 
> Add a definition for the EC.
> 
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

