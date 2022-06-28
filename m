Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9355EF3D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 22:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiF1UXR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 28 Jun 2022 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiF1UVk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jun 2022 16:21:40 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4251124
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 13:19:34 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so5270198otq.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jun 2022 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEvFuUJcgKjD1KK0O2ptd6IoziGK1DkrPBnMIs51Dlw=;
        b=viMzckyLSxyumGDXuvwbZfAH+ZpVcpddnKGKjmRdiZ7c2R+4pUF7GTRI4GEZerLJll
         9NZqbUSMRtLM2QyP3uKI4lsn42t40dCeV/aMayXiovylNS8+AtX73VbrJtYdodZ5c275
         R9f+lh5b6yd3dJDgsay575pZ11Bk8zfxYcrGLNtHnZkaO7Ly5lj7p8iQRSQcWPGPGovB
         X9VCCXVvkOq6AjNubZHRVVI0O3QaI+jwiIh6uGBib9951sMhZWBXZJp4UaTpVBl+PSah
         cq1uE8+2yGGXcT+s8rs32s1nL3Bgtr7iXAKVpFm7YFIdPhOXtOQ3DeuPlRUPRB0khkH5
         oqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEvFuUJcgKjD1KK0O2ptd6IoziGK1DkrPBnMIs51Dlw=;
        b=s274XNfH6U1Nd62NUTOFuVapwlGup2pJsrqJfJsBXn4XYVgDHmpTfKJXMnsqWDicDs
         c0U0DF21H9q2CV/LyGTbQQgDxppVwGfG8xZXwZxWrTFu4bbN1QB46iK6FRcNLKdZZYsA
         1RENlAII00zBiH2nfcY9sxlDqv+JzP2Usk1nhSMLxxKreKbJvecRVkzIBD9H+TIxWjwD
         1zjIDdSGkGQXXqsII3EGhzwf7MM3f46zK6iUvpiuVSWidQRfkIosCIw7rc733AWBriSp
         Qim5Y1SVe8/r4GiRMc9dJpqXxlBQW3zQwPChR8ANPlSH0g2LpYpG3KNjAPFX19O3QJld
         AnPQ==
X-Gm-Message-State: AJIora/SKXQVZ1V5EwIqRB11h1lhR87LAQXm7ndP46D9DczNPtY/vgLk
        3dB/+VyD1iWgcngtcCpM0bSs9A==
X-Google-Smtp-Source: AGRyM1t6GoZu1uEi97J1earoxokH7cav9I4fHY14+CKDIjkVDDzutLG1V153Sm7YjcURG36xlQccSA==
X-Received: by 2002:a05:6830:438a:b0:616:f238:1562 with SMTP id s10-20020a056830438a00b00616f2381562mr419026otv.111.1656447574266;
        Tue, 28 Jun 2022 13:19:34 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a12-20020a056870d60c00b000f30837129esm9536923oaq.55.2022.06.28.13.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:19:33 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-scsi@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: (subset) [PATCH v3 1/7] dt-bindings: clock: qcom,gcc-sdm845: add parent power domain
Date:   Tue, 28 Jun 2022 15:19:04 -0500
Message-Id: <165644753308.10525.1688009123553849699.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513061347.46480-2-krzysztof.kozlowski@linaro.org>
References: <20220513061347.46480-1-krzysztof.kozlowski@linaro.org> <20220513061347.46480-2-krzysztof.kozlowski@linaro.org>
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

On Fri, 13 May 2022 08:13:41 +0200, Krzysztof Kozlowski wrote:
> Allow Qualcomm GCC to register its parent power domain (e.g. RPMHPD) to
> properly pass performance state from children.
> 
> 

Applied, thanks!

[1/7] dt-bindings: clock: qcom,gcc-sdm845: add parent power domain
      commit: d62cac46b0184b8730c68b01359a33769fee821b

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
