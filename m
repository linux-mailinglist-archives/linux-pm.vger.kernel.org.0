Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B89761E91
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jul 2023 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGYQcS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jul 2023 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGYQcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jul 2023 12:32:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5778E11A;
        Tue, 25 Jul 2023 09:32:14 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9939fbb7191so7406466b.0;
        Tue, 25 Jul 2023 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690302733; x=1690907533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7OUFpBRNjEL1Ji4284oRxOr5gfFNrwntTwz1EGLyJY=;
        b=k5ei8QVHNxEYh8drof5azSl+0IzHBra1qV/vPSutC94DTw5Hj35DLS70qVB57S6/WN
         UCiFi12G4+2/hX1oxQMGNy/OBsY8YV2RoZKqmDrh1Adg+oyZ5SKiL9po8K0yP2mmAjFQ
         c7VCWSg1BtUt+7zCv1D0Yhq97nGbjsiT16cvBlGmVxcOrwUuFLnuFjBjEYk2VVAP6jAI
         TbHExtxQQGUxKrXuNxeRpfNWst4K6Hlzs+JM+CUX6gmpYboKYtHRmaSQAYH49JfxTzfJ
         6u9SU8lptXcndB+XmcTJb5jKV0AlSjhCEAuzQcAxsvbM12afObevAbrzqColJP1YjrtZ
         zu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690302733; x=1690907533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7OUFpBRNjEL1Ji4284oRxOr5gfFNrwntTwz1EGLyJY=;
        b=Aykqq/31TR71pYvKXs5e09w9uMXaCADaNlrzs27hFEr8bRy+9OSGNFifwLvLQDIN4G
         bT2aHe0ZAlbjI3FCPjuDrM/fJ3E8kb/y/LoZORX8BOXpG1oHFcbpbmgA2dF0cowy/VdF
         qqdb7jej4aSOf1ZFQn+V6B4vWVvt3gXg3tCTY0GvRynhLb3HTlSq/87j8BUy5xJWQCRL
         t5Xr19QKOCOI7kkqMYk/2KK0rekEJfQjF0copEkTxHN2WZYOTrU46JQp7q5NgsqdLNYd
         F14ihW8ydmz8zCoLPILPzpoqO2rt7WAf+L2PdCAH9b0bU4eEtSJOPLJAh7OcVxkHewJy
         8aUQ==
X-Gm-Message-State: ABy/qLbwg2roDTHWYAcMi4j5l1zQBTs6HcFKCcMN9LdjXq0wGJjqJ6vR
        stEmrLmf0k2pfXU6l77hteA=
X-Google-Smtp-Source: APBJJlG0SGhaTfgRA98HEMfheHzjUOz73IXFmeqkEzdbX+efl11IKYpoKc7ti0H43rNibyzkyfGCUw==
X-Received: by 2002:a17:906:309a:b0:993:da87:1c81 with SMTP id 26-20020a170906309a00b00993da871c81mr3060070ejv.20.1690302732715;
        Tue, 25 Jul 2023 09:32:12 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906080d00b009944e955e19sm8333477ejd.30.2023.07.25.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:32:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: thermal: tegra: Convert to json-schema
Date:   Tue, 25 Jul 2023 18:32:09 +0200
Message-ID: <169030265767.1427964.573776431679622911.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721130306.2990112-1-thierry.reding@gmail.com>
References: <20230721130306.2990112-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>


On Fri, 21 Jul 2023 15:03:06 +0200, Thierry Reding wrote:
> Convert the Tegra thermal bindings from the free-form text format to
> json-schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: thermal: tegra: Convert to json-schema
      commit: 22af900bdb02d7e5d983832ea8067fc5f2f01686

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
