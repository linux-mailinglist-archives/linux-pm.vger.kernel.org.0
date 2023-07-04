Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AD746D29
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jul 2023 11:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGDJW0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jul 2023 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGDJV6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2023 05:21:58 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB6136
        for <linux-pm@vger.kernel.org>; Tue,  4 Jul 2023 02:21:52 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b8baa72c71so2044389a34.2
        for <linux-pm@vger.kernel.org>; Tue, 04 Jul 2023 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688462511; x=1691054511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qb0k7Tk9sBjBH9U8D1AVIvcapp3wGCXnlEAXFhkWArA=;
        b=J5J1X9MFOY1XlVJ3akSpgRFCykSF5urpV4lGc2C+0tjgLkmaKvVKeK2sY7aNE/AtMV
         6djhgBA8gM1f8dt1NTTm0VW5b92ZyuEF4foqBB0V5DH1XUdYZelDmWPBS94DpRbPlKz0
         QNxY2DfSWzH8EAWbzv5uc2EWXxnu7t9qbwmjb07Z6vyfebPHmXcNFN6KpPMGuhmnazNq
         j0rRv/HXlouYxZ2fr+vlKwkP3HTDQtqVH4Xh9dBLj41kuL1afpH2IinjK4BVfrj0Wf4b
         x3dfoRc9umC6CzHAwTaEtWqdRkhq+I52iAIw24xWoNOPqeG+BRUhcDqLp5bOxLGJSNa1
         C88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688462511; x=1691054511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qb0k7Tk9sBjBH9U8D1AVIvcapp3wGCXnlEAXFhkWArA=;
        b=Sick+i/aJUZ/R/cXMUEpF93Vc06zWAuLg491qL9o5cpEWVA6HhxuWtk5EhdMp7w0tP
         i9SSCiexSxgFmcxc6JdXs3p9QUY4Q85N27oSGAEi4Kq7M8u4FOEhEOxfUelfDHh5XRRp
         athYOpBJ5VSvcqHWlzQL8g7YNTJ06imBwx9GUYM1AZdk0/IwnhtbgM3je9AvSdnSRzUB
         1h+PLzrSHhbcNKuuKMDhXkEPbR0n4jwyPpTdXNKH+4pEfIN0/OaJP+D8MWRzaxB+g9GQ
         8ROkPlaNnwJvZY55iPnfBoZBAX9BJ4V8VkGk5+kQW4ENeju0r0eIU0sgrm+0hJle//cD
         6lsg==
X-Gm-Message-State: AC+VfDyiDTSPrr4IZ0fV1OKovYdgEEz3NsI9pZplC8Vl2DivF7EILr0i
        4iYkFECX0M+e/WMDO6ArJOSVRg==
X-Google-Smtp-Source: ACHHUZ7IVwxQXfJq0vODWWLrpPS2yRDRI6ukM2UsLM5BcltZnCkJkcv99U/KbY0fLyDVlAK6Az/mtw==
X-Received: by 2002:a05:6830:2099:b0:6b5:c9c5:3e6e with SMTP id y25-20020a056830209900b006b5c9c53e6emr10758596otq.19.1688462511541;
        Tue, 04 Jul 2023 02:21:51 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id n189-20020a6327c6000000b0055387ffef10sm16209158pgn.24.2023.07.04.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 02:21:51 -0700 (PDT)
Date:   Tue, 4 Jul 2023 14:51:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: Re: [PATCH v12 01/10] cpufreq: blacklist MSM8998 in
 cpufreq-dt-platdev
Message-ID: <20230704092148.eh2yla64uo74dggk@vireshk-i7>
References: <20230217-topic-cpr3h-v12-0-1a4d050e1e67@linaro.org>
 <20230217-topic-cpr3h-v12-1-1a4d050e1e67@linaro.org>
 <20230628155656.GA542106-robh@kernel.org>
 <20230703041701.ntv2f2h7z2welmvn@vireshk-i7>
 <7299b735-d613-1306-796c-291f03f3b361@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7299b735-d613-1306-796c-291f03f3b361@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-07-23, 10:07, Krzysztof Kozlowski wrote:
> On 03/07/2023 06:17, Viresh Kumar wrote:
> > On 28-06-23, 09:56, Rob Herring wrote:
> >> On Wed, Jun 28, 2023 at 04:00:40PM +0200, Konrad Dybcio wrote:
> >>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >>>
> >>> Add the MSM8998 to the blacklist since the CPU scaling is handled
> >>
> >> s/blacklist/denylist/ or s/blacklist/blocklist/
> > 
> > They are already named allowlist and blocklist.
> 
> This was about commit msg and subject. They are not named like this.

Yeah, I was just saying we have proper names in the code and they must be used
here in commit.  Sorry for not being clear earlier :)

-- 
viresh
