Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50793EA224
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfJ3Q5f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 12:57:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38402 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfJ3Q5f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 12:57:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so2971830wms.3
        for <linux-pm@vger.kernel.org>; Wed, 30 Oct 2019 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QdY6TmK+2y/s14qGjHPxqB0jIXd8MwHLs26zXdSKXyo=;
        b=bmD7Hkqdf7uXcVoMVRdbMoeBgNoMMbYtDDMQY6sprJ7vUeXGYrqcg+O+i43cwqp8tg
         UqoRL4ynL+GX3RFQkptjwyDRAM3BtttyVBlJk1hCBAZxTaEnu+8a9mjmuj8xQeM83ykX
         eriHVoiIJvYciq9fBX7X7LTNNydhtLiJhZgVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QdY6TmK+2y/s14qGjHPxqB0jIXd8MwHLs26zXdSKXyo=;
        b=WcfDWIlnku7+tcbsT9s5GoKj1PXW+3e5zBb6YZI6SDUEDnpPt5/T7GmON1YDKByDfY
         Nbw/hn6OJmOVFzjPrVp+t4p+flSGItebhYAH8F7fCLLpsjSvcye6Cpn+II81uYJcQRzK
         /9C4ZQS5++lfEwuA8qd65wUIpcjLXs1crYEGJKUHMwxTVRJPVcLIlAcYZp7R7xF+F9hY
         fxb/7PXkMg5DnD97GFhwlBCvJdT7z56V0kP9tjgDrAvm63IBzp3ulnZx9xXiaYAiC8lz
         HBg5Ruzl/j58/PdCyKX1lUqSTUmHkrGlCLIrXXufSgKW/WgfH06i8SCZSVjp6IWlXGK9
         vq5w==
X-Gm-Message-State: APjAAAU56SNVZWhSePTPATQC7q1aIcoqR6mnfqkqG3XdqKIlIds0N8xd
        Q2U0iYFr73gxgaxa87Xm0oXH3g==
X-Google-Smtp-Source: APXvYqz5dKN657/XSJ3JgH9xSQmO8Ni/BmRdwv014BOEqPEYUzkkU9LiTkFVbIQXO+XWsVX5K82/ug==
X-Received: by 2002:a7b:c30c:: with SMTP id k12mr408919wmj.89.1572454652740;
        Wed, 30 Oct 2019 09:57:32 -0700 (PDT)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x205sm741097wmb.5.2019.10.30.09.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 09:57:31 -0700 (PDT)
Subject: Re: [PATCH] thermal: brcmstb: enable hwmon
To:     Chen-Yu Tsai <wens@kernel.org>, Markus Mayer <mmayer@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191030163807.17817-1-wens@kernel.org>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; prefer-encrypt=mutual; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0MEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPokB
 xAQQAQgArgUCXJvPrRcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFrZXktdXNh
 Z2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2RpbmdAcGdw
 LmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29tLmNvbQUb
 AwAAAAMWAgEFHgEAAAAEFQgJCgAKCRCBMbXEKbxmoE4DB/9JySDRt/ArjeOHOwGA2sLR1DV6
 Mv6RuStiefNvJ14BRfMkt9EV/dBp9CsI+slwj9/ZlBotQXlAoGr4uivZvcnQ9dWDjTExXsRJ
 WcBwUlSUPYJc/kPWFnTxF8JFBNMIQSZSR2dBrDqRP0UWYJ5XaiTbVRpd8nka9BQu4QB8d/Bx
 VcEJEth3JF42LSF9DPZlyKUTHOj4l1iZ/Gy3AiP9jxN50qol9OT37adOJXGEbix8zxoCAn2W
 +grt1ickvUo95hYDxE6TSj4b8+b0N/XT5j3ds1wDd/B5ZzL9fgBjNCRzp8McBLM5tXIeTYu9
 mJ1F5OW89WvDTwUXtT19P1r+qRqKuQENBFPAG8EBCACsa+9aKnvtPjGAnO1mn1hHKUBxVML2
 C3HQaDp5iT8Q8A0ab1OS4akj75P8iXYfZOMVA0Lt65taiFtiPT7pOZ/yc/5WbKhsPE9dwysr
 vHjHL2gP4q5vZV/RJduwzx8v9KrMZsVZlKbvcvUvgZmjG9gjPSLssTFhJfa7lhUtowFof0fA
 q3Zy+vsy5OtEe1xs5kiahdPb2DZSegXW7DFg15GFlj+VG9WSRjSUOKk+4PCDdKl8cy0LJs+r
 W4CzBB2ARsfNGwRfAJHU4Xeki4a3gje1ISEf+TVxqqLQGWqNsZQ6SS7jjELaB/VlTbrsUEGR
 1XfIn/sqeskSeQwJiFLeQgj3ABEBAAGJAkEEGAECASsFAlPAG8IFGwwAAADAXSAEGQEIAAYF
 AlPAG8EACgkQk2AGqJgvD1UNFQgAlpN5/qGxQARKeUYOkL7KYvZFl3MAnH2VeNTiGFoVzKHO
 e7LIwmp3eZ6GYvGyoNG8cOKrIPvXDYGdzzfwxVnDSnAE92dv+H05yanSUv/2HBIZa/LhrPmV
 hXKgD27XhQjOHRg0a7qOvSKx38skBsderAnBZazfLw9OukSnrxXqW/5pe3mBHTeUkQC8hHUD
 Cngkn95nnLXaBAhKnRfzFqX1iGENYRH3Zgtis7ZvodzZLfWUC6nN8LDyWZmw/U9HPUaYX8qY
 MP0n039vwh6GFZCqsFCMyOfYrZeS83vkecAwcoVh8dlHdke0rnZk/VytXtMe1u2uc9dUOr68
 7hA+Z0L5IQAKCRCBMbXEKbxmoLoHCACXeRGHuijOmOkbyOk7x6fkIG1OXcb46kokr2ptDLN0
 Ky4nQrWp7XBk9ls/9j5W2apKCcTEHONK2312uMUEryWI9BlqWnawyVL1LtyxLLpwwsXVq5m5
 sBkSqma2ldqBu2BHXZg6jntF5vzcXkqG3DCJZ2hOldFPH+czRwe2OOsiY42E/w7NUyaN6b8H
 rw1j77+q3QXldOw/bON361EusWHdbhcRwu3WWFiY2ZslH+Xr69VtYAoMC1xtDxIvZ96ps9ZX
 pUPJUqHJr8QSrTG1/zioQH7j/4iMJ07MMPeQNkmj4kGQOdTcsFfDhYLDdCE5dj5WeE6fYRxE
 Q3up0ArDSP1L
Message-ID: <6c681697-c9ad-02a1-8289-fa265cea36c8@broadcom.com>
Date:   Wed, 30 Oct 2019 09:57:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030163807.17817-1-wens@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Chen-Yu,

On 10/30/19 9:38 AM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> By defaul of-based thermal driver do not have hwmon entries registered.
> 
> Do this explicitly so users can use standard hwmon interfaces and tools
> to read the temperature.
> 
> This is based on similar changes for bcm2835_thermal in commit
> d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

There a number of patches that I need to get upstream from our
downstream tree, because right now the temperatures reported are note
quite in the expected units..
-- 
Florian
