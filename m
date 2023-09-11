Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA80779AFC6
	for <lists+linux-pm@lfdr.de>; Tue, 12 Sep 2023 01:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbjIKVHh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Sep 2023 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241467AbjIKPJa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2023 11:09:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD0CCC
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 08:09:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4018af103bcso28859645e9.1
        for <linux-pm@vger.kernel.org>; Mon, 11 Sep 2023 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694444962; x=1695049762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOYptsCrf1diNtyghWnfZLvZu7tELTtIDAUqFPNMvD8=;
        b=nDQUTuVqNirbN+JZkauDGGsx/C3cOoBtpn6rQEEf+1xn63eqKYNA4YwJCDeWqn1/bF
         uDDIh5u2ZYKhDnne8viz/EFUHPg9pHiTeOVrIsoi6UphXjE1F73GxiX1DdNvXCzUKFFc
         ur+JX6Z5CXaviw4I1FZfnIPf3Zc1lWLbLjWh3XkoKRX/OGZTgzhHPNLpP661FdlW3lMk
         t3RdH+PEz0rYZ+kxPz2y9LO9cS1DpAymt11DJahyiNLgjqWVgv/v8fKwmGAIoD6hzWnF
         9RBNPfVM2aZzPI+ZJ6OA8Aw8Oi0j3r/uufM55v77msMpqbBl/5bdyWIJrBKxWiAsGKlb
         /IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444962; x=1695049762;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOYptsCrf1diNtyghWnfZLvZu7tELTtIDAUqFPNMvD8=;
        b=Fwdcqd5S2JigtcsWg5T1Hj0oPqosgH5x6tl0pxszqO/p8Kxk7WkDheRp15Dqopdkas
         IKz0x582owv8wmixEg6W4mlp27V0CyyWFhnCOXvfhL6sDBvbxccB6T4Y/tQw/s1zUfm9
         0S5gksILlwhvxdggBKVZa0gDlnlHOneH9OljOcZYfIbBHISYShERj30ic+YkkAbTMb1w
         T38V+Lpqg408oGoefnF9mGGzeq36sSw1IxryM6tcg7QO/Bg+LYozMIdjKY1qWHjaTZJU
         xmDbVm/yzFBvN8uPCwrhI50IYt6r0w2qpqDWeTGxUbTnMzqiPtdy3Rg7k4Y7IPRU2H80
         JpYA==
X-Gm-Message-State: AOJu0YylS6qi8B4/+oo3Gwbo5BK8QNcbXIZ7pgybfQAWvcQoxdhGimjJ
        OZkjBkzy1+OpTroSBMXnlq+xCQ==
X-Google-Smtp-Source: AGHT+IHvwIKHqGYnGN3IiqndAH93l6WqVDjqInO1zvq/pqTFA0C05t49HJS1dXDWNdJXeVZleDHnqw==
X-Received: by 2002:a05:600c:2209:b0:3fe:1587:fdf3 with SMTP id z9-20020a05600c220900b003fe1587fdf3mr6762828wml.14.1694444962015;
        Mon, 11 Sep 2023 08:09:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6152000000b0031f3780ce60sm10388691wrt.7.2023.09.11.08.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:09:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
In-Reply-To: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
References: <20230911025223.3433776-1-xianwei.zhao@amlogic.com>
Subject: Re: (subset) [PATCH V3 RESEND 0/6] Power: T7: add power domain
 driver
Message-Id: <169444496123.3944766.3763051739383485051.b4-ty@linaro.org>
Date:   Mon, 11 Sep 2023 17:09:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Mon, 11 Sep 2023 10:52:17 +0800, Xianwei Zhao wrote:
> First patch is that remove C3 some power domain ALWAYS_ON property.
> Second patch is that add driver to support power parent node.
> Third patch is that turn on power if initial power domain with
> "AWAY_ON" property state is off.
> 
> Other patchs adds power controller driver support for Amlogic T7 SoC.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.7/arm64-dt)

[6/6] arm64: dts: amlogic: t7: add power domain controller node
      https://git.kernel.org/amlogic/c/5355699dabac3c97492a30e6e01820fcaae11218

These changes has been applied on the intermediate git tree [1].

The v6.7/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

