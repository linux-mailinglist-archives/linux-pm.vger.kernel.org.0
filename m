Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695A651AC25
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359616AbiEDSGa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 14:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359647AbiEDSGL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 14:06:11 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C226D3AF
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 10:21:30 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id l203so1868811oif.0
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2022 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wGaNEgkga2C3vR38cQjxSl3nf4BfaDAQqYW9Vv/BBTc=;
        b=PEfoXor+JdsqfPlN+A3GqSST7jD5o0bcF7nggWSaH6F54b6L4ub2nPZsEEL0/L8je6
         L4JS9CJXWZsNNZdMhgBhz8n/d1YQjBCcUoikb8NTH6h1ofErB23tOgwNHxn5sNy9bd4g
         ntydlC27R1G0Q0xUUUXK4+0O7HIoYEPFZkFa8VglaiHOo+ojUHG41As2Q925/PPtwt8C
         6iuIXGAuAWlSWr/laNZFzGfJAnj1iKhjkKwrm3tE7kBS4LgCeeJHHUMtWl70k+08eHIy
         qMJvomyu/rTkI/PjGmFUaHuimmIVCIwk6c3fZpoGkteqD/ynqbLr1fDQq2tqvz3Klae9
         nevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wGaNEgkga2C3vR38cQjxSl3nf4BfaDAQqYW9Vv/BBTc=;
        b=WWK8V+WiHkrZrzd6Up5WkQoaO5xWO2z0UCj4aFcXoD6aMc33UZLXbzlS2BG3wj9DdQ
         FbMWQGhmdb/x+02jDlTlbt/3h69G3o5pN8UF/0h8II+2ObAzw8tzsKCUYVg7ItDMdZmj
         qqQtJ7tZFa+2AWlytIuUWh2zsMk8n017gs5X//97qrIarpysZAoIOG8UZ2AztYohkpel
         7UulQXq8r79OvLyBsd2lsTg3R2Z0hL44Fu92KcRNAmHe9Ehm0IZ9HDq4BijczQMqyelg
         GPpI9iXgjRSdmB8MZhk9y/Ghg9J9OhKkUxNhFMTBpK1mb9e9SW0gd5GBYIR71G+8V7dU
         0KSQ==
X-Gm-Message-State: AOAM531Oa02czRLmIN3LnCtx7g8Ka2IeWS8h4DblnUjcGsKTDsedPoJ8
        +rKr9HtrINr+f5hLXOmBK8BAGA==
X-Google-Smtp-Source: ABdhPJwa6dp2UBzeU6Egf+BrynvyfLaVErlWkcSLlDE67ay70zmXc3sc2mENXNU1OiQ9R77IHyoDJQ==
X-Received: by 2002:a05:6808:1646:b0:2f7:50ea:85f3 with SMTP id az6-20020a056808164600b002f750ea85f3mr242567oib.137.1651684890264;
        Wed, 04 May 2022 10:21:30 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alex Elder <elder@linaro.org>, Georgi Djakov <djakov@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Taniya Das <quic_tdas@quicinc.com>, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: (subset) [PATCH 3/2] arm64: dts: qcom: sc7180: Remove ipa interconnect node
Date:   Wed,  4 May 2022 12:21:14 -0500
Message-Id: <165168485226.3730817.11676742538463355486.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220415005828.1980055-1-swboyd@chromium.org>
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220415005828.1980055-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 14 Apr 2022 17:58:26 -0700, Stephen Boyd wrote:
> This device node is unused now that we've removed the driver that
> consumed it in the kernel. Drop the unused node to save some space.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sc7180: Remove ipa interconnect node
      commit: 067bc653b85e466048914c48e46659a50a907fa6

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
