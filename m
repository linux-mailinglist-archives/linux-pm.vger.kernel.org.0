Return-Path: <linux-pm+bounces-4406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0886796E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 16:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9148E1F26FFD
	for <lists+linux-pm@lfdr.de>; Mon, 26 Feb 2024 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCC130AFE;
	Mon, 26 Feb 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbPBzyEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDB12BF07
	for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958587; cv=none; b=tN4MGyKxFvBsnmm+fmboEV+QpsMNAGdImzoEuLOz1cFzRlmvuVX46oXz0zeQzuI7N92smYHYSfLwmU0JeDYCxXJ7++0kE5z/zNmE2Ntz0toV0PSOA+6cFSLd+lcE50KO38AZP1dOqdgEKHL9taMCXZtTmmfet+sLnS9ppB+TwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958587; c=relaxed/simple;
	bh=194/ZcRx90rMT6lhPS7u93Tfa7QH/NXGR85wnsvgn5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3Md/2pdGGB4ilwQwVDwy9zYt6MzmbPGMUQ41c3NBVZYZczV+BkTGPxj7Tn4Z7RG3lXFim7AIKXa2KZv4aZom7dHPc9Y6Vd5VT1k9YitHh46io0HhLYBfwW+aN+n8Pt9qio06vLVw9MpBKWWl9GA1bYSxYAeNw9HIXFyNoNbDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbPBzyEG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41298159608so14457405e9.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Feb 2024 06:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708958584; x=1709563384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9tbNaYjJUe+G+wb/l7hVhkbXYhWJjIHDAkvy08BoSQ=;
        b=AbPBzyEGQYrNJGEAKMfDv6AUSvzbGZsU3PAhyXTa4KdkMVXcOGi0pSnF5sredsxVT9
         B3Iia8TFBXkZX5FCpS3QSoVq6rs/IYrKf8h0Sy0aAJpDXOYJCChK0JImZA9d3TDvmX44
         SIRGEwYafdF8UlpqB2j25Z/O4mt6FL8LLzUVrXz1h2VS4TUcjX9i8VTR90QbKeXjJwaC
         Yqlkg7DlFv5PyqwzO4DWelZ2+MRUarfuZ5QFhiYa2sZhtdqmzvFVnroJFBz2NPNmbhwj
         XxPJZVJ1zGPDiUFapK6Ks0Z7BW6m4SaD7tCihnErgqP7B7ix30uXd3qQ9bX5QY798vBD
         12Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708958584; x=1709563384;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9tbNaYjJUe+G+wb/l7hVhkbXYhWJjIHDAkvy08BoSQ=;
        b=H+UScMtEqXnc0AvGmbV39QtOQB8DA/iVOpKAQNmNREtPdlKxtZRVItb9liZ/Hk69vV
         AAQI6dRKBetazE+vSrU6D160LhAc6Vb2aBGQ7iz1mJSnoJKdM++lPTTzECZJnotVvZbk
         2+hEKWYKe6TbCyjjj9qMTwueywrHE0SQEQzNvnwq7R8d93yA7r1nYdtHJGA16SU4LehD
         bp8VQORKTIVXI3MwiVrPugB47ZM3qvgMYpvS01EWNB3PpqUmRUQj5O2CTnOBv7LOjR0U
         wyKv2CcEB6mNeg2qde1RSJsKmlVzMvjlqqhGQ+tkI1vY5duYE9yhqx4oBr03m0txugo+
         BPJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX308CndHyEnKI4MaRk0xCxrlKn5FyJt+rvDzROCsQjjF8QC91u+xrcO7jFkl2SnTQyhGC+nXOBba+tGnZTrixZ/+0g/tQMJgM=
X-Gm-Message-State: AOJu0Yzxpge7exJn/gKsRswJb8iMEyFJSuoRSIPSZtsOPsb/wGDmN3bk
	ACnlVL8iJy6RHop3BPhhqu1pW7G4rPztjiimukzuFW9243s6iGcpki8ZcsYAPfI=
X-Google-Smtp-Source: AGHT+IH2Ee7jy/1HUKjhnM0FzWr1llSFk1mmZxb+jGS8XK1HpX8qhtkl8SiSACuchuYO1pFYaOe8YA==
X-Received: by 2002:a05:600c:1992:b0:412:9c2a:7622 with SMTP id t18-20020a05600c199200b004129c2a7622mr5989940wmq.8.1708958584336;
        Mon, 26 Feb 2024 06:43:04 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n1-20020a05600c4f8100b004127ead18aasm8586036wmq.22.2024.02.26.06.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 06:43:04 -0800 (PST)
Message-ID: <6f4a4d7f-e258-47de-ae9d-026370339641@linaro.org>
Date: Mon, 26 Feb 2024 15:43:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] thermal/drivers/qoriq: fix getting tmu range
Content-Language: en-US
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, rafael@kernel.org
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
References: <20240226003657.3012880-1-peng.fan@oss.nxp.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240226003657.3012880-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/02/2024 01:36, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> TMU Version 1 has 4 TTRCRs, while TMU Version >=2 has 16 TTRCRs.
> So limit the len to 4 will report "invalid range data" for i.MX93.
> 
> This patch drop the local array with allocated ttrcr array and
> able to support larger tmu ranges.
> 
> Fixes: f12d60c81fce ("thermal/drivers/qoriq: Support version 2.1")
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


