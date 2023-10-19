Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6507CEFF4
	for <lists+linux-pm@lfdr.de>; Thu, 19 Oct 2023 08:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjJSGQR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Oct 2023 02:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSGQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Oct 2023 02:16:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA1711B
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 23:16:12 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so4602471b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 23:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697696171; x=1698300971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yH/UjLgq32jH++PpMoUqJLeIFE0ZYZEDnxQSEj9bfyQ=;
        b=XhQ9rch0+74TVCHpR01n3JHumgle+KuMfQscJmbaLNgjAh2Jqde2xQDbA+N3Crk8fi
         a2WLAWqMwipqF4DdSDHumJCyN0L6bWFQHLcb0DSkiqrOZQsaZVDkuVVYrdBGAIGqhCxK
         QPaze6Bn84FFwXoDAKtSUzhWGnzxYS1FWprqj50rGJiyaCtbHTxHzdIQlf2jSfA/Dyh3
         igPWdmrg3yYoUtBVGldc6ENP7hzbihwScFYDNLDW0UiKAqQz2V7EX4N29/lx7CVN8fWB
         7n4+r2S4GCQMCjJQUNWKJzZ4fecndvvLrJERZsd9xw+6eeu0NI3k+qUlTfdM3gYhGc8l
         h1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697696171; x=1698300971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH/UjLgq32jH++PpMoUqJLeIFE0ZYZEDnxQSEj9bfyQ=;
        b=qwu2enbaclKut46XKjX9T2vUZgSqhr6JxtxpY3rWj3fmWGrPGd344HvooRS9OgyB6l
         ckFeTG2Jpxp0YRHsSB3Bprjd9x5/cYvXuFm68RYHxkl/mPvOeDbwg4PYVU2Fh7XFljBX
         U+n02E5Pdzmy/xXkMG3nT823xLSWAPZ0PBRBUoyvb7y0yb90So7To01CXTE/g5svdyj6
         oVygbUPoauot4V0MESxMYKRLur0uFq0hcQVhQit5M4rGgPg3LkdUlAvcNmm5aUNffV4P
         IJEA577qF4XWXwyiJh/XaZzhxs4J0wsK81TKeQdEwbD2MtxKodgqLjZf2qbSv7oQ/SrG
         iEhA==
X-Gm-Message-State: AOJu0YxcEKTs4ri+T5DSSaIjAzsjCu0QoYtcZ/i0HulflGjRNYhjMCSx
        32wTFFZa61o58ve6FGhKLryqzw==
X-Google-Smtp-Source: AGHT+IFaTXuhZLlg7nK3UyK8fM+1t0TG+C2O2i5DXfpYAeJ5f2mO+dwIkmiwoqHBiZRsQHyYhwplMQ==
X-Received: by 2002:a05:6a00:1a8f:b0:6be:3c44:c18b with SMTP id e15-20020a056a001a8f00b006be3c44c18bmr1167269pfv.25.1697696171321;
        Wed, 18 Oct 2023 23:16:11 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id x13-20020aa79a4d000000b006be0bd6a4d8sm4325600pfj.36.2023.10.18.23.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 23:16:10 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:46:08 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/3] cpufreq: Add basic cpufreq scaling for Qualcomm
 MSM8909
Message-ID: <20231019061608.wjlf4orkdlpnv3a5@vireshk-i7>
References: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018-msm8909-cpufreq-v2-0-0962df95f654@kernkonzept.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-10-23, 10:06, Stephan Gerhold wrote:
> Add the necessary definitions to the qcom-cpufreq-nvmem driver to
> support basic cpufreq scaling on the Qualcomm MSM8909 SoC. In practice
> the necessary power domains vary depending on the actual PMIC the SoC
> was combined with. With PM8909 the VDD_APC power domain is shared with
> VDD_CX so the RPM firmware handles all voltage adjustments, while with
> PM8916 and PM660 Linux is responsible to do adaptive voltage scaling
> of a dedicated CPU regulator using CPR.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

Applied patch 1 and 3. Thanks.

-- 
viresh
