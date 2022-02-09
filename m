Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1B4AF431
	for <lists+linux-pm@lfdr.de>; Wed,  9 Feb 2022 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbiBIOh0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Feb 2022 09:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235099AbiBIOhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Feb 2022 09:37:24 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31BC0613CA
        for <linux-pm@vger.kernel.org>; Wed,  9 Feb 2022 06:37:27 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8A28F3F1F0
        for <linux-pm@vger.kernel.org>; Wed,  9 Feb 2022 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644417444;
        bh=SlwgImOcNTsESNfIirUrDaCeHIHfLp+o6BSrCLR6Xb4=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=SAFAUlSBUPhWTzILpRb4Dp1S7+on+6mklAGFRX08QXESci5j9uhWutKUHbajoXpd4
         bEcbKpgKaJMuR4oKJwLly+i0wNlU297opk9SwX83DlHNdeyA3ZjktIkbxzsw6O17+w
         5xPcHP4bg3CP7jZrZo8A2eF4o8t+vPw3T8U9EqIrSHw0zEGQChk3avgIlHtpNGGS3f
         VyADZgy180qc0q0m5f/S24VoSfI4ameB41Xe06zwqbiYbb59XzVU5bhZ2B4qa8U6Xn
         FBpNOqKqxs75ZOU1mFVl7WE/yG927TZUmRUU2uUXoZYXXhYIhdjkt8Gqdyb1ItTxyt
         iW/6jIrmXPNSA==
Received: by mail-ej1-f70.google.com with SMTP id o4-20020a170906768400b006a981625756so1307932ejm.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Feb 2022 06:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SlwgImOcNTsESNfIirUrDaCeHIHfLp+o6BSrCLR6Xb4=;
        b=i6KtZdvhpy7OvqLpJLICqe+20QUpDmI5mhMocNEaOUvrP2jv5M6ODA0QYY01fYmEyR
         SgVUlMhx9pDcq2ENhKjJ6ERgsSRwvTjMHi3wiFQboSUbtbOpgWgdLtGuY+kQS6YPEzUU
         b+NC7KvJ0Oy2HbAP6YIQDaQ1knegpQv3jchhhMRY0U/kRnSUvCSBq1wO6Cio+MEm2uuY
         seNpdYVvAuv9oqKCUQCtC24TbaUOjlWR4EVuX7tQotFtnK9TqPTK1apu9YUOaGWQt/WN
         NQjl6ypaJ8fXBhJ218Rw89Wmhy+jE6xpiFeJPabPkoYJF/U1ZipGkmLJfWqcPzjpphox
         BBTA==
X-Gm-Message-State: AOAM533VeRVQ8/NOfNBRF432C4QFtUV8HYMAZDw/a+oMURWW6HfHM26z
        y4xZT12gzXAA2c1zhF5G2yuIw1tbdiNTHMFbBQIqad+C8+IEkpFlzt7TEDxJ/h/N3tomAr3F0zm
        E6jVyfqRRTesBVHCkEmgBX0v92Yc9/hP6+rXv
X-Received: by 2002:a17:906:240d:: with SMTP id z13mr2248958eja.210.1644417440962;
        Wed, 09 Feb 2022 06:37:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw36sjymzMaJhJa6q6wUBDPfAQePXwC/8alKtggTfvJQrQ42VevrxvY9v64oZZdAuv2SAoLgQ==
X-Received: by 2002:a17:906:240d:: with SMTP id z13mr2248941eja.210.1644417440823;
        Wed, 09 Feb 2022 06:37:20 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id ss14sm3871136ejb.199.2022.02.09.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 06:37:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-pm@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/8] dt-bindings: memory: convert to dtschema
Date:   Wed,  9 Feb 2022 15:36:44 +0100
Message-Id: <164441736490.181274.3751600144129167050.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 6 Feb 2022 14:57:59 +0100, Krzysztof Kozlowski wrote:
> Changes since v2:
> 1. Re-order patches so timings get converted earlier. This fixes dt-checker
> robot report.
> 2. Add Dmitry's review tag.
> 3. Three new patches:
>    #6: dt-bindings: memory: lpddr3: deprecate passing timings frequency as unit address
>    #7: memory: of: parse max-freq property
>    #8: ARM: dts: exynos: remove deprecated unit address for LPDDR3 timings on Odroid
> 
> [...]

Applied, thanks!

[1/8] dt-bindings: memory: lpddr2-timings: convert to dtschema
      commit: 425fd283e4a2b929a88483525fda3f90dde8a2d0
[2/8] dt-bindings: memory: lpddr3-timings: convert to dtschema
      commit: 180a276c99bb861742c5c423d679b0277d4b1c26
[3/8] dt-bindings: memory: lpddr3: convert to dtschema
      commit: 28f818580e49a97876de5c33231fc0e4c3cde2d9
[4/8] dt-bindings: memory: lpddr3: adjust IO width to spec
      commit: d98e72b6f9b078c57f9d46dc64a669d02ff2ffcc
[5/8] dt-bindings: memory: lpddr3: deprecate manufacturer ID
      commit: e531932c7185b86eccb3688002730950d49eba1a
[6/8] dt-bindings: memory: lpddr3: deprecate passing timings frequency as unit address
      commit: 42f94bb962cd1b15dc57c90aca7e48848ca6c6c3
[7/8] memory: of: parse max-freq property
      commit: 4e890b2228fd14fa6269175e9816bf27ff989e84

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
