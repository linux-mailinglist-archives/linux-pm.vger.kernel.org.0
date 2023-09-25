Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9C7AD6EC
	for <lists+linux-pm@lfdr.de>; Mon, 25 Sep 2023 13:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjIYLYU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Sep 2023 07:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjIYLYT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 25 Sep 2023 07:24:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B148101
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 04:24:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50325ce89e9so10171287e87.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Sep 2023 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695641051; x=1696245851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMhmMAQQbl/7qD+DBAIyGJ2AG8c+5UuMVzq4znI+3L8=;
        b=g8p9/4FKFnMY5PNu7jaucK+xOc9vl50UhHgSTb1pm8FhSYghQxjl4DAxhVANmTKTP7
         zlgKau0n+r0/478OUsXbw8a5OctYBaWQRUkAjA5ghoJWQ18IeMsJ3Ev3XuwcFXVxD4Rg
         imvCt4OwF6gVk76FzaYTh3j1xb2qMNnCzs40OXaA15CiEBMLd2DrvvGmJFaeGXQ4gJLp
         5npCJlNRMirQQNhG1mz9rZ8oyNIdcHzIvmMfXlEa+ti5Cv+Xxh1ZsUOasgk8yE8YCe1U
         ORQ3WTg2YBUGdJIxEQRYezZiR2aQVukb6jr4Q4Xu7bqiLQqalR7l4i9Uxw1+lCRH+uMm
         h0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695641051; x=1696245851;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMhmMAQQbl/7qD+DBAIyGJ2AG8c+5UuMVzq4znI+3L8=;
        b=Dvewl/GeC4xsCZ0pYZeYXUhBnz6M7rD8I2zumLaTOzhmMr4ztFIlXuaUvaGj8ig9hG
         r8LNJneTl8HUhyrThybUqo22wTGGUwC+iDuWsEp4dYeu6UjlLVeF0FlHo06t6hitZsSt
         Zvn2cNTt5Obssrn30lPrV8Owfymepp+vDmnujmQg8b1tPp65Gqqy/scOo5P/mFAk2WoD
         sp2oqj7PkUCoB0rDn8nXtY145M/zVAaBdUGcaqOtbozdTsTfIlDHNRc7NxCGyj04ucLi
         VrmXh3d24580FB0aDYxWFtm7OJN28IkWpPQjvdJClqeZslVQW8d+0p/oW1z1lASYhURO
         uXHA==
X-Gm-Message-State: AOJu0YwHmGbWB4Vo3Izyt9aClrnJuKkcZnkZRnFGXgjspiA1SC9z0wka
        VzTpiD0hkkoSFDh622NpHrE5CQ==
X-Google-Smtp-Source: AGHT+IFqIBkgVpP+AhlxyEQ0hkTfnfhpfzlJa4GthGn4gn/ftTVslN7s9txRdFNAZVQPZpNXmO0eXg==
X-Received: by 2002:a05:6512:3d9e:b0:504:3424:215c with SMTP id k30-20020a0565123d9e00b005043424215cmr6852228lfv.51.1695641051028;
        Mon, 25 Sep 2023 04:24:11 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id x62-20020a50bac4000000b0053443c8fd90sm152170ede.24.2023.09.25.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:24:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
Subject: Re: (subset) [PATCH v2 0/7] Initial support for the Fairphone 5
 smartphone
Message-Id: <169564104980.23811.11629211382725152116.b4-ty@linaro.org>
Date:   Mon, 25 Sep 2023 12:24:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 19 Sep 2023 14:45:54 +0200, Luca Weiss wrote:
> Add support to boot up mainline kernel on the QCM6490-based Fairphone 5
> smartphone.
> 
> These patches only cover a part of the functionality brought up on
> mainline so far, with the rest needing larger dts and driver changes or
> depend on patches that are not yet merged. I will work on sending those
> once these base patches here have settled.
> 
> [...]

Applied, thanks!

[2/7] nvmem: qfprom: Mark core clk as optional
      commit: 844ac302b2aa81c47a4323fc34a0a454cc749dbc

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

