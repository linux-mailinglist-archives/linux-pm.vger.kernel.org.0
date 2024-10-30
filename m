Return-Path: <linux-pm+bounces-16749-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE26B9B6969
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 17:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC881F22507
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2024 16:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA042144DF;
	Wed, 30 Oct 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0g7pG/M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E628F7;
	Wed, 30 Oct 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306572; cv=none; b=PLlnN7mA6yftBF/oFF/yGY+t41nTC3XlzX3zSLiUB8SvyJd+7uhFmX+st53PqqIfsu4TYvBcnsiIe1JdBYM5qtof+4WJvWY8t/8Bh7M/ZZ7mZ2Ply/LlRdEHfDNwIAE/xFy4R988UOd2TcJsM6GfIf4LD+e9jG+Fh7kCOD9+/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306572; c=relaxed/simple;
	bh=5xjpOCeLDUgrrz6mIFaffw2Gl/gRe/dRQDUDilNTcpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoHYqfHd094AUQCzUplG5XYBDNQLWRzPUvexxlQ/NG+I8NNg4SaqgctmVDmelWAfW/EiHV2E+XQ3+aRHs1tVujdtOyebGl+EcRg2aukuFD9Hoqbsq5oNmPWcPGs2OSUkziDNCER8TSMTSYLCP3g3PYErzHbnYHHQmBnJfY/4COc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0g7pG/M; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e6005781c0so33961b6e.3;
        Wed, 30 Oct 2024 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730306569; x=1730911369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=upSDuC1ThIa1MLUW5v1BgSDrV6IlSUCAGHtCh8ZshGc=;
        b=a0g7pG/MWkkJrWBf/iTLq3i9j8kOhP18Q5qWF/X2R+e8bj4Sm/pgaOxaNRaWQn65xQ
         LyRhQ91sS51QUWpVh4SUydgHybmYd+hj1d0g+SoLCtEjR6Dr9OIqgdLHvI/lc3dq9gue
         yAXh60TYOy9TrlqA4scOrcZF99P6gfH8UN+iCCDqggQJXmb/AKikLDSkUUnrIw6x2OOQ
         ESicDIsRiuHKJ02R9X0mQ7FJq0/hF984F1DdGn1F92mrdEQ7vo9BlzE1G7eas1XXrvLK
         sCD1nh6Cs/4ySv6FhjihCMVnKohI71x/PoyGeNs2QHKhJD2I5COsDNVZIkq/Lvsyai32
         7vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306569; x=1730911369;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upSDuC1ThIa1MLUW5v1BgSDrV6IlSUCAGHtCh8ZshGc=;
        b=n6AhcpR6WUih8qj80hw1VxsPyie2u0GJFt/Vw1qkOXmpF6VpIJnseH+35gz2fgQ6UH
         RADAQXSd4AWTbGp8xIxvnXoqRyQjja4tVMmRjVGeOTDsQ+t4yLpdYY2mO5gO2GSVs/Y0
         ZGDPFnGzKLMlHHeL1LdIXOerEmpyyEAS315ALYwMobwZjkAzzBlGFBBrxdcdJky3SRNm
         5xb4fBqj5M6V2UarzTSfkmP7RzHFEwbUv+2NuV7tE+pEXK3sieojbHF6Asc2tYGDmuFm
         CeRH24yaN9dBoeP7kZKJtbr4YK0RJeTOW/K3zmyPay99tcsxdbKiuYWgfv8GN76cuxS4
         p7cA==
X-Forwarded-Encrypted: i=1; AJvYcCUeDeZQ6A/AyMJSsrXfJirubOk1wNEtsD1Da2uQExoTDxQ4r9evwaNwdsXa3tAPcjZRavvkoi5+gg==@vger.kernel.org, AJvYcCWFaLqXnMm96sK0Q5JKCsNty2xIKtijn3KA2jUFNr674SXVUsPEdR6FPFJ7pmNaBnNIIqnealpObhhfXgqnZQ==@vger.kernel.org, AJvYcCXy13PBTvDSkmqijHve1i23y028gQ7j941QqqDjsA4a2GoxY1B9ZD9pui6CkYq6AP3Bz78RlEkXkVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNe0ClpPnBDc6U7uKPhLZ3OFiUAJYvUFcah5vEzY+lN7mbAzAX
	E0nI892rpqhhuvu4az+ZOJheS/YTpqujV1tETGvlUgKfijUN4eeE
X-Google-Smtp-Source: AGHT+IHL1aIqEXulP9B4SfFxolZuQqmmUNNlYSLSaXx4g8iw5vjflDUjFis9TIxnhkRmWiBuQlo1PA==
X-Received: by 2002:a05:6808:30a9:b0:3e6:1473:19d6 with SMTP id 5614622812f47-3e6583bdbcemr4558447b6e.29.1730306569452;
        Wed, 30 Oct 2024 09:42:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a84absm53560346d6.39.2024.10.30.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:42:47 -0700 (PDT)
Message-ID: <f4142cda-c8e0-48c8-aff3-4dfa942b37fa@gmail.com>
Date: Wed, 30 Oct 2024 09:42:44 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/6] firmware: arm_scmi: Report duplicate opps as
 firmware bugs
To: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
 cristian.marussi@arm.com, johan@kernel.org, ulf.hansson@linaro.org,
 jassisinghbrar@gmail.com, dmitry.baryshkov@linaro.org
Cc: linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 konradybcio@kernel.org, linux-pm@vger.kernel.org, tstrudel@google.com,
 rafael@kernel.org, Johan Hovold <johan+linaro@kernel.org>
References: <20241030125512.2884761-1-quic_sibis@quicinc.com>
 <20241030125512.2884761-4-quic_sibis@quicinc.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCZtdNBQUJMNWh3gAKCRBhV5kVtWN2DhBgAJ9D8p3pChCfpxunOzIK7lyt
 +uv8dQCgrNubjaY9TotNykglHlGg2NB0iOLOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241030125512.2884761-4-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/24 05:55, Sibi Sankar wrote:
> Duplicate opps reported by buggy SCP firmware currently show up
> as warnings even though the only functional impact is that the
> level/index remain inaccessible. Make it less scary for the end
> user by using dev_info instead, along with FW_BUG tag.
> 
> Suggested-by: Johan Hovold <johan+linaro@kernel.org>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

