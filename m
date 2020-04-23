Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F11B5783
	for <lists+linux-pm@lfdr.de>; Thu, 23 Apr 2020 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDWI4w (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Apr 2020 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWI4w (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2020 04:56:52 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB8C08C5F2
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 01:56:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so5658871wmh.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2020 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gPzpvlWWEkxl/GFcREXb7mvaG/UydxVYGTUgIsUo/dU=;
        b=T8uFtLGrcfPG+2nC3WnF8sbFdbxtNMTsCsZb5h7zXdNuK8D1lQWl/bhbAPGdq1qA5s
         GHokk7+lKGkW4+G3kJL7t//29MNS6Te82c64dTTOPjMiRw3r66JHc4gA5HT/Tan46luL
         z/4IThEwdjsVd7d+XuMDCm7WOsPgvGq4mSF/cUQRVWVKpcYXeVc2xeAnYBjZOBiEfCzc
         Zma73Lvv0oEBcJ8g9cAlSy2SsQTRC8Zk0tVSny4A69dY03R72XfBNdXGHXlZy3kUYQe7
         grBdl0ipnmRY8hi6jZ1Rqbopra32g/XCOVUeauh5zxDzvByW3TA6Mqy3IBkD1HSik9IJ
         JoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gPzpvlWWEkxl/GFcREXb7mvaG/UydxVYGTUgIsUo/dU=;
        b=RqVLPY0eQHtbTyfyHMRuJlR52u7bzALXNHBTgjhszwI96tIHs6taONZBqSEJlJb6VH
         eCLF8ifZlTJk+lrDe5Iowo9BdlpBqtZpqHwKn3qZ545NgnEqCLfTF+kUx+LCdDQUY8Wf
         IRYeYZ4s+jU+/m7pcOAIo9jtBb+iHvwwgP0DLQU1k+BpMn6HD63zP9LkF1o+qJooNiOe
         3GU9PdBIBvmXvtFTWslyDF1/OLyHfuQxK5Xjhzavt6NX6LOLViGSzdI8ygPogKVsBzEP
         CRi7qFE7Uu59n7w0uZB5YeRMv2L7RQt2FhoWGhvjTJkEhIjB1qNYTOO0CsmPx3Ni47AY
         n3Zw==
X-Gm-Message-State: AGi0PuZvYQVZyhDggHR+roJ8Iudn4QLfLDhs3W+ucxRDFx5TQS0H1T6a
        NbophOJsAmSZFhjdRYZY5UbPyPXPPJE=
X-Google-Smtp-Source: APiQypL+L94ldf52eXuQQdOMwOat1gAOMuXsdD/6mf5xHcSdVlWgVimqMZsXeTLQrUQSvNNSpM3T3Q==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr2991240wma.89.1587632208686;
        Thu, 23 Apr 2020 01:56:48 -0700 (PDT)
Received: from [192.168.0.136] ([87.120.218.65])
        by smtp.googlemail.com with ESMTPSA id y20sm2759588wra.79.2020.04.23.01.56.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 01:56:48 -0700 (PDT)
Subject: Re: [PATCH] qcom:sdm: move the static keyword to the front of
 declaration
To:     "chentao (AS)" <chentao107@huawei.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <ae29b195-3529-e993-0219-cbf86ac4281a@huawei.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ab7820c5-ec3e-21de-b18c-739853a8dc3f@linaro.org>
Date:   Thu, 23 Apr 2020 11:56:46 +0300
MIME-Version: 1.0
In-Reply-To: <ae29b195-3529-e993-0219-cbf86ac4281a@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 4/23/20 10:16, chentao (AS) wrote:
> Fix the following warning:
> 
> Move the static keyword to the front of declaration of sdm845_aggre1_noc
> sdm845_aggre2_noc sdm845_config_noc sdm845_dc_noc sdm845_gladiator_noc
> sdm845_mem_noc sdm845_mmss_noc and sdm845_system_noc, resolve the following
> compiler warning that can be when building with warnings enabled (W=1):
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Tha patch is malformed and i can't apply it. Maybe try using git format-patch
and git send-email instead of Thunderbird.

> ---
>  drivers/interconnect/qcom/sdm845.c | 16 ++++++++--------

I can see the same warning from osm-l3.c Could you please send one patch
fixing both files? Also use the prefix "interconnect: qcom:" in the subject.

Thanks,
Georgi
