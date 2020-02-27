Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D35A172112
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2020 15:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbgB0Oqo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Feb 2020 09:46:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55355 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgB0NpE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2020 08:45:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so3619282wmj.5
        for <linux-pm@vger.kernel.org>; Thu, 27 Feb 2020 05:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRpjg7VfxAWAXWCyVK3TF778q7i9qgrUQjd7ke8MZGM=;
        b=DtblLM/HbuiDe6npECTn3ll10Od90J455eJP7dLeDSNxFNbJ5yW3943M5CWNGBGCca
         3ENV/gwcavsjWQMKfAYy7zoj1Km8KGj4ULjZkpaKfwNFmkCLyc70QJHDLKw3V4etqwGn
         aa/6HN3YZyIiRCgvoKIGN9egLIIAA5YQWrfSOBmlw3uxPm2+FxEI9spvtBwDYeLVgJnR
         0iYg5Rtrce/IuzWJA2QArG+fSNwYxnD85Y3keU55NPvTPmDG47k9izsaHWVJcNJNAAgB
         FcseVC3Y4T+U8L9JPYQpYurbrHHJDhrMtyCcFFmK6h3lBPOjCwDEocwGgBRkPCFTxLLa
         2w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRpjg7VfxAWAXWCyVK3TF778q7i9qgrUQjd7ke8MZGM=;
        b=n4uGTsosiEnF3WbifC11BAfD4Roo9/nIVnuVKcFcMRPVF23tOOVpyM0Z0szvRvvcHM
         kYm+fymbGGb4BF3H9drqbpHvV4Xbk3gyFlEZbU6kEmyWuA5izY5E8/28R2N5Z8q/PCHw
         /YB5DJqcjPrsuC8Yd1UBZwsDO3es7p7QljJOVLNCR0B5ZQfnQeOvi734q4Geep6UbGye
         iAdKacnhFLE/KQgNY2zdtZijDxTUBonEY8w/9S/370Z0Dfvq4bu864Q/nL1DQ6aOM4I8
         20r0QgSjv8NJEKTxCqN7g9vNci37eZgwiGYwxnEKf/z1q+zcXLoMHQVnpCadprQFw/6C
         05vA==
X-Gm-Message-State: APjAAAUDH+zBBOAc7Fv34eF+Q0yZfuZ4AOrmgWBUtwz9/C8nYhpjbwNO
        H2OMzaxYXF73VSO4h1eX0xNF7w==
X-Google-Smtp-Source: APXvYqxbH2LzNiuz8OUFlrSiYa48j4DRaQWKby7I1has1etckZRz2eo+zWt7xkZGhT2Zx67Nss+abA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr5639230wmh.155.1582811102353;
        Thu, 27 Feb 2020 05:45:02 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a198sm8024152wme.12.2020.02.27.05.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 05:45:01 -0800 (PST)
Subject: Re: [PATCH v3 6/6] arm64: dts: sdm845: Redefine interconnect provider
 DT nodes
To:     bjorn.andersson@linaro.org
Cc:     Sibi Sankar <sibis@codeaurora.org>, robh+dt@kernel.org,
        evgreen@chromium.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mark.rutland@arm.com,
        daidavid1@codeaurora.org, saravanak@google.com, mka@chromium.org,
        linux-pm@vger.kernel.org, Odelu Kukatla <okukatla@codeaurora.org>
References: <20200209183411.17195-1-sibis@codeaurora.org>
 <20200209183411.17195-7-sibis@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <261391af-18c2-5da1-a094-326be58b313f@linaro.org>
Date:   Thu, 27 Feb 2020 15:45:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200209183411.17195-7-sibis@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2/9/20 20:34, Sibi Sankar wrote:
> From: David Dai <daidavid1@codeaurora.org>
> 
> Add the DT nodes for each of the Network-On-Chip interconnect
> buses found on SDM845 based platform and redefine the rsc_hlos
> child node as a bcm-voter device to better represent the hardware.
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Acked-by: Georgi Djakov <georgi.djakov@linaro.org>

Thanks,
Georgi
