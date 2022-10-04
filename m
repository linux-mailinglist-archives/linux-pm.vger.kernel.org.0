Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E615F485D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJDR1R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJDR1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 13:27:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B675A894
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 10:27:08 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk15so22374089wrb.13
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/YyTjuq72jPuEDAkHmrIcGfQEw89UamE4234MBXV7M=;
        b=uMNscTXfVp1XcvvH3eELBtEjbKgaXl4c6QBHfJoOtBNGqoIT74k6Z+iv7KETLsf/+z
         /eZxN1xc4aU+VLXZt8wrd0EPElxdHLvBPS7pbMgOz8sfXGFKaJP226csW7xKnNFx5/ky
         jPNpNdkvnaNtJGAOQr5Mppd7vhvpMmRL5qil2FcFdnGYJU8zWjq+WKGF+kkJhps1wxyg
         jSKMlAAX4xteHY09iSnwCGY1+GoxMz4g8ShNwXiV0H4nbYSLGkMyF5zel8RIqPx8SWMw
         3O+nv907n1rElz7mH2w29j9bCRrOT7e3zhzKVDcqbUsBfBiNFZzXjVz+Ge4dVceY5wSG
         8PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/YyTjuq72jPuEDAkHmrIcGfQEw89UamE4234MBXV7M=;
        b=FBX+4BeItR+xumIARUXXslrzuzHhq56glxTb/hd/X9d86ybfAzqK9RC10K9xZ1cPGC
         70Jnm3H9rPY4DiwueadrIs1nIb/3MtKOEFzddLmi3EHYZY4Qp9d5fl+ai1tzYfSZqH6B
         OgUM779r0X+bEmkOKkKh36Kx6OvaJe+rP0PNRf8aEsbyZvmcRNHIOwNUplbbxnrcJi69
         YY3iZkwP8GRbFNrgucLP1XUtsHVCWfutFuOZqzeOb0V/aCiR1K68MkVdXN9cNG+QmS/T
         hQPPmgt43cTUm/e08SNTtF8+JDWzhdU0AEosl0od3rHw2UyyBH4rLhteIMMdiU2KMW5L
         KEAQ==
X-Gm-Message-State: ACrzQf3KmydCpqpCEnUJcvsxPPD8nKueh0sAKV+6W4iybPudb76ghTF4
        ElcRcjPCADk1pCVgZHuR+LXQW8bLtv3NQQ==
X-Google-Smtp-Source: AMsMyM7eM2MqbsI26hUF8cdejktV0Fb2N4hpKCRdY1miuh+p/YeKBiq26ZYFa9sRudB/orQu/ipWZg==
X-Received: by 2002:adf:f911:0:b0:21e:c0f6:fd26 with SMTP id b17-20020adff911000000b0021ec0f6fd26mr16849049wrr.361.1664904426795;
        Tue, 04 Oct 2022 10:27:06 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.gmail.com with ESMTPSA id l19-20020a5d5273000000b00228dbf15072sm13060941wrc.62.2022.10.04.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 10:27:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/9] ACPI thermal cleanups
Date:   Tue,  4 Oct 2022 19:26:49 +0200
Message-Id: <20221004172658.2302511-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <12068304.O9o76ZdvQC@kreacher>
References: <12068304.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
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

The thermal framework is being cleanup by changing how the thermal trips are
managed. In this process, the ACPI thermal drivers deserves a big cleanup in
order to use the generic trip points.

This series, which is still work in progress, has been tested on an ACPI based
platform.

Daniel Lezcano (9):
  thermal/acpi: Remove the intermediate acpi_thermal_trip structure
  thermal/acpi: Change to a common acpi_thermal_trip structure
  thermal/acpi: Convert the acpi thermal trips to an array
  thermal/acpi: Move the active trip points to the same array
  thermal/acpi: Optimize get_trip_points()
  thermal/acpi: Encapsualte in functions the trip initialization
  thermal/acpi: Simplifify the condition check
  thermal/acpi: Remove active and enabled flags
  thermal/acpi: Rewrite the trip point intialization to use the generic
    thermal trip

 drivers/acpi/thermal.c | 670 ++++++++++++++++++++++++++---------------
 1 file changed, 433 insertions(+), 237 deletions(-)

-- 
2.34.1

