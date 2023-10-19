Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637CF7CF4F8
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 12:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjJSKUE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 06:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345203AbjJSKUD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 06:20:03 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C05F119
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 03:20:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7b3d33663so104329167b3.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2023 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710800; x=1698315600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+2ay1Mv9/C/v7lm4yctcbzZyj+Oa+YNr3iWCqPoUf2M=;
        b=h5Z/y7cFwgKw9S8cVQcz3HXGtNJ482/Ay6QvTVj5BIhhHjpsBC6AtLd2GgG5whjv1T
         4AK6TzxScahwldNiLVBT9KlHQp7bAKa20Y5qhpjSfaKmba3uuY5eTlHvH0kVy3L7L9/Z
         DxjmGXZ5yA/4g2KQNmgs8WsW1QDiBjPpPpYsvmAHQWMcsEe/8worgV2rQwOjQ1TE1byp
         Cp6sAVfva1DDTbkqptl/RlP0HkRVLHDuplW7RLnnxMd1WI/go4pgNEMUiHuG+aCxYPCl
         aUS09EB0oxeivbcK1KJy3cQN4va/4rQmXQT4pKdk2eok3+neGx8SeB2xdpcDE7Xub3mF
         dX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710800; x=1698315600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2ay1Mv9/C/v7lm4yctcbzZyj+Oa+YNr3iWCqPoUf2M=;
        b=UJ8BbTDyo9b5/KPJ23AJNOWZ93ttCMKO2zI70J27QFFV62PyCvPc4iE1/JUgN3Db3e
         cXoFDlLwfTDjv5i7w8sS4IqIkiE1YnUaNOJ2L1dmOnl3byiP/Q+wNhw0CQB6o1BBkpNQ
         lC/0XuKju3KJnVu4dWVyUqJuARUT5aT7pRcuWuXMVAsJ2CpqIUvI+H9o7BpqKO60cM0p
         Xb74lzvcTJII9ZyaMpVpimPlwbRtSCHdFFvefFfIyTlD1ae80aUugwUMp4m7/lWNo+Df
         hDr45aF63wV1NmsAN5Dez32rLxqRLYspNSpYviit/YgZXMPc5lj9MQGFLPMJNaAgWYqs
         TxkA==
X-Gm-Message-State: AOJu0Yxw3b1Kvgm7SZI355kETjkEVW0D3+vd4p/JB2atnfxSw8n1ynJf
        b3UneqExeMq5RLtvqFIO3juX11W0xriggU0P5c3iJjgdFKD82ucY
X-Google-Smtp-Source: AGHT+IH1co3QGaifyt8+FiiqfpjOwl6MBA08MqBPrTv2587EQVcy78LceP4jDc7WDl2ukXOpfEvW2AFLyTZgEbN6+oQ=
X-Received: by 2002:a25:d0a:0:b0:d9a:fd25:e3ef with SMTP id
 10-20020a250d0a000000b00d9afd25e3efmr1674227ybn.64.1697710800490; Thu, 19 Oct
 2023 03:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com> <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
In-Reply-To: <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Oct 2023 12:19:23 +0200
Message-ID: <CAPDyKFr5xC6yaB4REQ5FwROfh_Rsfco5KBw4A9T9A2JZepTk8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm MSM8909
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 19 Oct 2023 at 08:16, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 18-10-23, 10:06, Stephan Gerhold wrote:
> > Add the necessary definitions to the qcom-cpufreq-nvmem driver to
> > support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
> > the necessary power domains vary depending on the actual PMIC the SoC
> > was combined with. With PM8909 the VDD_APC power domain is shared with
> > VDD_CX so the RPM firmware handles all voltage adjustments, while with
> > PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
> > of a dedicated CPU regulator using CPR.
> >
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
>
> Applied patch 1 and 3. Thanks.

I did spend quite some time reviewing the previous version. Please
allow me to have a look at this too before applying.

Kind regards
Uffe

>
> --
> viresh
