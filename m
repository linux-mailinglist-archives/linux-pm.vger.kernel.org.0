Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8D746B78
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 10:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjGDIGz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 04:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbjGDIGs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 04:06:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A703910C3
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 01:06:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so9377862a12.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2023 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688457993; x=1691049993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjbqSxKHCJgXg3U2nlCeT+KCbY995FI3c2bsWZQkAcM=;
        b=Jb5ruiqCjNOBocFFKc4AyscNKSiqzI+gVjdfXEWjvAmGPxmmGXg6jRWhHJWbtR6RnA
         VoPohLPkitsogM4xLGX7XJdpgwIw6AYWdp40byZlfPkB9Cx4s/+zndmk5nEJUfGXqIdS
         enD+db+L3zcfJb/O0Jt94v+ndFDRCWU81792irK0hO7VmceZjK8Elg9kme0/IL7S54FH
         vhp0NRvCvuvfriHWvFNATp2UUVNpqNjpN6JXF3+AuhCV3U5VNiNZ94s9CuTtY2C3PiT8
         03/hDv52iJnEtjwegE2+sgZTjNmovsxW//H4HOH9JpNTfvOEcMgpDuHYW/VREoAJF2A2
         i7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457993; x=1691049993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjbqSxKHCJgXg3U2nlCeT+KCbY995FI3c2bsWZQkAcM=;
        b=VRH8WKSRGrEaXJtmzLkmD6nFu72fG8eJl+3mF2bRU0DTZ6j0kLALE/4pGVebmTJHCD
         ekg80slFjvlbr/sqoTUgkHt4BfiU3WNJUp5kbHyLamIvM86jRUfSsjZS2eBBPEA/5zQl
         H/CpJp3eFhRDffcoBjJgSuVPfo8VTSpQ0zEj+QKP8Dwqt2DiGpfD39Bp4wZ5lzbiWktp
         OcSc4FhBi185OcBJNmOpfbF8jR5dLWKjtmLl+M3xqDMA74wM3YdA/Q8H7CPzqhfP+Qdr
         rwRadrpZS3eY9o4x0MvzQIi+crV82ocZ9Ymz1LztQRuaQ87JvEJA0rEHRNbzaiK6Smlp
         I9ug==
X-Gm-Message-State: AC+VfDxKcxUkxlOr54X0b1qiHsr0zPGFKGvoptf32s4vzujMgXVqHYZL
        Mkpvd0AcFw5SIZ7yKjw6Q460hQ==
X-Google-Smtp-Source: ACHHUZ77nYO3/EIdisXr06nHjl1fn/QdhhvBuc0MzLLacMsqfak2G6UTzVEkdaDz2J20cWtzRHGlBw==
X-Received: by 2002:aa7:d51a:0:b0:51a:4451:564d with SMTP id y26-20020aa7d51a000000b0051a4451564dmr17195416edq.18.1688457993298;
        Tue, 04 Jul 2023 01:06:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f6-20020aa7d846000000b0051df5eefa20sm5053254eds.76.2023.07.04.01.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 01:06:32 -0700 (PDT)
Message-ID: <efba4d51-c98a-b646-d643-0a5b6875f9a9@linaro.org>
Date:   Tue, 4 Jul 2023 10:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v12 01/10] cpufreq: blacklist MSM8998 in
 cpufreq-dt-platdev
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
 <20230217-topic-cpr3h-v12-1-1a4d050e1e67@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v12-1-1a4d050e1e67@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/06/2023 16:00, Konrad Dybcio wrote:
> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> 
> Add the MSM8998 to the blacklist since the CPU scaling is handled

It is "blocklist", not "blacklist" (both in commit msg and subject).



Best regards,
Krzysztof

