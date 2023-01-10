Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9145B663AC0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jan 2023 09:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjAJISq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Jan 2023 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbjAJISn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2023 03:18:43 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE1342E02
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 00:18:41 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id e76so11012680ybh.11
        for <linux-pm@vger.kernel.org>; Tue, 10 Jan 2023 00:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq6kbFa9Q6XePoTGZMyOqndZFFNOA4hEyY3g6DmupTM=;
        b=peSqu6O2atn6rcoXsO2zx056ilEHN6U4fJ0NwepwoB9a03kpyGWlsG8S+S4f44GhvU
         EomHOSgabfexEYSUmzfCosXXWVBOZsuiRslBuuSRgU+keh/2x8TA7MvepwuS9VPu2Ddm
         UMY6JOeug81X3/FaWz3EYU5q9ZlZk3OJ1VZxDOiXhY93tvHjU1I49Gwcfz0axXtEBboV
         pZo8S18ayW+eMwynh8wWT62o1Hek5swzQJ6xzAndMyPYLWDYNNY6fZdY8tgklzfYDv4B
         jkAjhJb47GCRwwXXEIrK/nZ2njMYdMh/YiWPKWmOKCOpiBT+/kwie4t/xc4BiR8JhLGi
         1ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq6kbFa9Q6XePoTGZMyOqndZFFNOA4hEyY3g6DmupTM=;
        b=VQLdFICmDKCtIhMCkKVkF2pTEjRIDVNJRj27DBdzyYDomnOnmlbNCSay8sA+H5jvuK
         E1NDXM5nfNIG/cr4w/yupItXpakBll66jlF9wLG1HJaiPqUSn4fMpnhcaZ+POTCrATvN
         Z6KVqVaUnxlQh2sRqa3xm/ETNi4wpbbN6LD8t3eII1CBPW3Ur6S/DDKldf9GMRihHGHe
         HIHNGEiALwFlQPl8JecnNQHoSeizpaHJZ9EcpuFF+Ui98FES7Bo66B1Xw5YYSfOVfQW3
         ZCfm1mMUurqxHD0Ln4Xd5eNWIzPKIBDHxx2nuFxRg0RpM1EZsujfGRHgDZY6F14h2lS/
         IRog==
X-Gm-Message-State: AFqh2krHA1MVEQ48w+qELe3iOoMjGMcdqqIR2KpNq7nn1P//864n2eBq
        tn8vF1k0dcEH1gr+EwJ17+PAUYKgdhQ4T9hX/il6YA==
X-Google-Smtp-Source: AMrXdXuRBov6hoRRwKns5OAP09txTff/z7ySQGBUSEs6TNAFQ9Usf4qJbJA5b0gLCb3g8S1mE0oGzUkYOtYbbFCRf1I=
X-Received: by 2002:a25:4903:0:b0:770:d766:b5e8 with SMTP id
 w3-20020a254903000000b00770d766b5e8mr4722239yba.24.1673338720651; Tue, 10 Jan
 2023 00:18:40 -0800 (PST)
MIME-Version: 1.0
References: <20230109174511.1740856-1-brgl@bgdev.pl> <20230109174511.1740856-11-brgl@bgdev.pl>
In-Reply-To: <20230109174511.1740856-11-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 09:18:29 +0100
Message-ID: <CACRpkdb7C763xYvZKc=6-oZtGGtqSwdNK5j_aA16f6j7bR1yqw@mail.gmail.com>
Subject: Re: [PATCH 10/18] pinctrl: qcom: sa8775p: add the pinctrl driver for
 the sa8775p platform
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Alex Elder <elder@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-gpio@vger.kernel.org,
        netdev@vger.kernel.org, Yadu MG <quic_ymg@quicinc.com>,
        Prasad Sodagudi <quic_psodagud@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 9, 2023 at 6:45 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Yadu MG <quic_ymg@quicinc.com>
>
> Add support for Lemans TLMM configuration and control via the pinctrl
> framework.
>
> Signed-off-by: Yadu MG <quic_ymg@quicinc.com>
> Signed-off-by: Prasad Sodagudi <quic_psodagud@quicinc.com>
> [Bartosz: made the driver ready for upstream]
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Overall looks good, Konrad has some comments to be addressed.
Is this something I can just apply in the next iteration?

Yours,
Linus Walleij
