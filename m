Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABC255D0A4
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jun 2022 15:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbiF0LnY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jun 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbiF0Lmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2022 07:42:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B1B30
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 04:38:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i25so7118473wrc.13
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2022 04:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6pvGGZaD1oTvFXpN6ftachY08Cd5AqxujCjHUCfc6vc=;
        b=nNWDY3PjoyUAfo3JFCEPweVZN45kAO4FJmCz++XnV2gMusNLaZwqyHicnSW6ovjL7j
         JC59MWCAvvw9199bn821CUtYgbJ1VDgQJ2pSXAvMOX97nyamB0+tanaWXJcBWf+AQuFu
         RIwu/kxplbXL3l5O1dbb8FyCnKzKRNlmUa9XoMoI5Ho1H0eEKP2Xh1W85vOZunEP6qYQ
         ZaPsVHFIYawk82olsBV+7ZpWKlD9/Ea9eAbtWrWQq6CJ4c65fua5GjkMdVnaqdeiceF3
         qQqyse60dXLDqPW6aGAUklQTWKrD+WJ6+leF6rblpPBla3JPtXVHRZWEqZRW6hUefmcj
         mwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6pvGGZaD1oTvFXpN6ftachY08Cd5AqxujCjHUCfc6vc=;
        b=ndUeSb0ca30AFGOtA1AgsIfqP3kKzA+uHEvgqfEjkEOitUR6+VPz6QIzoAAXknDhzG
         YEir3MJd6baOSgcMN2TsW9AybroxF6n6SANMgD0EJtYjzaLxoAb4KoRIErSTJTbbIihq
         vCwc+M4xlKtGiW54Y4vZN2Ms7M95W/I6b4mxX+d6vM1VuFX56Y/ZAFZTQWW3mDcDZ2pC
         4nyuazzWFOL5sOqrKhrxVFZq+ALWI3U+SXzNFmcFmZQ2W87ZLV2ow63uiR/ioFcrMmgM
         FZn54l5uqoWaHz8WFhXllmVgQiVrdZC496PgKadc7igbp42lhRQHCqf3ELPB2Gn8fu/w
         JHoQ==
X-Gm-Message-State: AJIora8F3ExHdRsy3cxk75YUDFBlIrpdCMbSbdMH/1QfH/TpmRPjO6Sp
        IJ1s81GPUzt13W9QtfYSYRM82Q==
X-Google-Smtp-Source: AGRyM1uXQLS8Q4aWycz3GihHCBPtSuHKP6mCc1QtRIrYhgNavIXv6w56zaZYob+9hvQxA8Jfw5/bXw==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr12146464wrr.2.1656329896780;
        Mon, 27 Jun 2022 04:38:16 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o19-20020a1c7513000000b0039c18d3fe27sm12450076wmc.19.2022.06.27.04.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:38:16 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:38:14 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [GIT PULL] Immutable branch between MFD and ACPI due for the v5.20
 merge window
Message-ID: <YrmWpn03cys9WUK3@google.com>
References: <1843211.tdWV9SEqCh@kreacher>
 <2653857.mvXUDI8C0e@kreacher>
 <2726954.BEx9A2HvPv@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2726954.BEx9A2HvPv@kreacher>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rafael,

As requested.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-acpi-for-rafael-v5.20

for you to fetch changes up to 0c9b9c2ac0df57b6b5949a51c45043b345698428:

  mfd: core: Use acpi_dev_for_each_child() (2022-06-27 12:22:06 +0100)

----------------------------------------------------------------
Immutable branch between MFD and ACPI due for the v5.20 merge window

----------------------------------------------------------------
Rafael J. Wysocki (1):
      mfd: core: Use acpi_dev_for_each_child()

 drivers/mfd/mfd-core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
