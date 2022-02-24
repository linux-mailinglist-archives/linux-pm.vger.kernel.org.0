Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEF24C3739
	for <lists+linux-pm@lfdr.de>; Thu, 24 Feb 2022 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbiBXUzR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Feb 2022 15:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiBXUzC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Feb 2022 15:55:02 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F91D3074
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:54:20 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id z7so4935383oid.4
        for <linux-pm@vger.kernel.org>; Thu, 24 Feb 2022 12:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0KXK0xF1IgcUQaOSKfdu0f84Q+tWkS8umD1NOtlRp4=;
        b=ddXzKuAoSo7hYp6PbMu80shGfrrtJyY6W07ehq42p+jMRWupqRcwRHnC5V9du1kW+D
         k3XhW2ZP0661BNEcJdk5GjCqk2w+PFqOdOaJBgEH6L4U9vXuUTi9l7Shq5bbHimxeNZG
         +fNFGCV1E9zErDNPypTj0FVfJTRUACpyYMf0lttPX4oGIG/KS4PpuYSZ/0tsIaRd07+k
         dup5ojfrT7wNpDGq6lD/XbKFVVD5QDbpzyepYcscK//l+386ivho0t/x9Qncgqh1Zc2W
         zba9ly54kiDj4FvJ3c0E+uMbem16AtQ+NaOPMZuHTUUgkLhWxebVK4BSHdCiuIKLCxxi
         Karg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0KXK0xF1IgcUQaOSKfdu0f84Q+tWkS8umD1NOtlRp4=;
        b=hF79r406XGCfMe/WSpawDaVMcSnNwBPvjFsZSNjB+MUoA1nbARWR+AeiRulQRD2AVs
         w9VLYK3BhlZsPUIbDVNpxnxiDLk1prZ4GBerfPvXrbd6sHjpIfDU9z6F20DbYHjGXAJI
         PTHnD2pl+k0Uhf4b5/ye+oM1Auxe0/IegEvEymuboAYoOojOO1s/yZ3SfgfZ5/DJRPSE
         ZjbwlIeGgB6tHDz+yzV+QR5Gn8wtxXUEjbaU/oOVh0v0e5ZDb6ioWhT0Ao4tDgmMpEeN
         jCbEAERzH1uM94sG+QZsvIWWiJG0XnQRaPbC+/n2JSm9mcJAqzrManpupXNPBz35kTyI
         1rHA==
X-Gm-Message-State: AOAM531+V/6qV6ZwCO0oT3xAqUei00meuuAzewlUS10iuSoRzDeIqyF3
        4kem/E+9BheaVPZkDwFDISwieQ==
X-Google-Smtp-Source: ABdhPJy1P3XRtwni+V/oOQ7cmDC7Gf0wptkZqIGd/Y7bzGfkWgQbUgVxIwf54i4GELuF7xMQy5m4yA==
X-Received: by 2002:a05:6870:ab86:b0:d6:e2a7:ce6b with SMTP id gs6-20020a056870ab8600b000d6e2a7ce6bmr189895oab.135.1645736059904;
        Thu, 24 Feb 2022 12:54:19 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:19 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     evgreen@google.com, Odelu Kukatla <okukatla@codeaurora.org>,
        linux-kernel@vger.kernel.org, georgi.djakov@linaro.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Cc:     linux-arm-msm-owner@vger.kernel.org, elder@linaro.org,
        seansw@qti.qualcomm.com, sibis@codeaurora.org,
        linux-pm@vger.kernel.org, saravanak@google.com, sboyd@kernel.org,
        mdtipton@codeaurora.org
Subject: Re: (subset) [v8 3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
Date:   Thu, 24 Feb 2022 14:54:05 -0600
Message-Id: <164573604161.1471031.13646279401339635883.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
References: <1634812857-10676-1-git-send-email-okukatla@codeaurora.org> <1634812857-10676-4-git-send-email-okukatla@codeaurora.org>
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

On Thu, 21 Oct 2021 16:10:57 +0530, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider node on SC7280
> SoCs.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: sc7280: Add EPSS L3 interconnect provider
      commit: 8b93fbd95ed46bb0d57e63c65cef155a09a75bb9

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
