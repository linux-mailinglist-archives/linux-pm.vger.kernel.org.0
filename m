Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF350A26D
	for <lists+linux-pm@lfdr.de>; Thu, 21 Apr 2022 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389398AbiDUOaj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Apr 2022 10:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389253AbiDUOaK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2022 10:30:10 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC723ED09
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 07:27:20 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id z8so5793973oix.3
        for <linux-pm@vger.kernel.org>; Thu, 21 Apr 2022 07:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ax4avlN0oglfzD6swQB5upAnrR9vbmcO4lly1CB9MS0=;
        b=WsC04F1RsX1JNzcannfCWEjoteFcPfSy9HqfKLlLLTSxKaAMW7vo8kPvQ7SvxIA6Az
         9YtRXmHBaxvC9+gXLPvne/Qy+0JtquZhXTKVBz5Ea99QSDnatgl1Ir0cnm+nIHD8GLYl
         G9lIfXbTKgztzzhNMoNW7xaq4yvZ2xzkfXXfKBRurKTXLxBCIbdsin7VitVBvUFo7fD2
         BMLl1XY+ISNNf9Yd9ZL7WADg+zhKDnfBQ8F4wLelxoXPNzDcLlTSR0JigF5DZteMcXTd
         9ooTO4DRB31uXzPaPfZVuBZtmL63ckMptbfxHy1rT689f4dbtNMflQ+kL9z72FB9g2rk
         mOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ax4avlN0oglfzD6swQB5upAnrR9vbmcO4lly1CB9MS0=;
        b=MzNemwRCB64wHvYCTzotB4Paqm7SxXpQmJ+eoyceD0+kLKJ4WX3u2lVD89B+46a0jn
         TWVBqbIkcbNnCeELJzc3KLdmeQdBD5exhg9f8UA9A5AVzhvOxlj0shmDRy4zjnlHLfdi
         FTl1LlsVN9Ds6sufJXyJ+zbTsGHcK3aSb7DkIwzFYr6DyBENBM+/TJL9H65Kge5CdC6L
         QHe1W+Z0E8beDSX18er5W2pMeU0nIzbqtpH9mcwbrabDG22EbC24glBIM9RPcODNMzNP
         yburzJEjDAO1J3pInt3c7Ac1w7OvXQ29d+G+rjDAvZhrA34mpCzk4HYQU0COhksEN5in
         BmRA==
X-Gm-Message-State: AOAM533iOtyX6xsWmWoDxSFyOb48KkzhL9pbdadaMNNcy1UczNR8KYUb
        29zkZBlHDV+ROko75mb9XOy77fXRR65d0Gl5
X-Google-Smtp-Source: ABdhPJwaFVAfSTDez3Zu80iJyqsv3GD/rPUN1R5xCe3IUJJdfZQU4qTP1ofMsk33NJeB4R6esgp1sQ==
X-Received: by 2002:a05:6808:180c:b0:322:3d43:c38b with SMTP id bh12-20020a056808180c00b003223d43c38bmr4162516oib.8.1650551239426;
        Thu, 21 Apr 2022 07:27:19 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s14-20020a0568302a8e00b006054e841915sm4296295otu.73.2022.04.21.07.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:27:18 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vamsi krishna Lanka <quic_vamslank@quicinc.com>
Subject: Re: (subset) [PATCH 1/4] ARM: dts: qcom: sdx55: do not use underscore in BCM node name
Date:   Thu, 21 Apr 2022 09:26:56 -0500
Message-Id: <165055095989.2574292.3311309854371304681.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
References: <20220411085935.130072-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 11 Apr 2022 10:59:32 +0200, Krzysztof Kozlowski wrote:
> Align BCM voter node with DT schema by using hyphen instead of
> underscore.
> 
> 

Applied, thanks!

[1/4] ARM: dts: qcom: sdx55: do not use underscore in BCM node name
      commit: 568cd3243331b6bf0702665f7bd90baa93e2b3ac

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
