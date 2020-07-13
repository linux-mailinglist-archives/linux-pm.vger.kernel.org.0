Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE9321E02D
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 20:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGMSvd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 14:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgGMSvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 14:51:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA057C061794
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 11:51:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x72so6404405pfc.6
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2020 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=617BtXfhDhCxYwKbF1MbJDp6FkHkJ91InZTtwhgrWAc=;
        b=LYgd5M71atEpjo9+l5VDZyOrkPHo9IZuDVdMJYTe4U36kp8vOrC2TapmJ94j/8UYjJ
         jIEt+3OwdsGQQYvAr3ySOyYYhy4X26dlaOpJV9sAg1NvJQn1Oxrm3vxfzDSrEDJaHUzj
         g/VMUbc5LxVbW9KyCIxKvMDO3FGJwRAhPNAEfElYDGjrjAND8qcfgqmAREnmg+2Pqj72
         62k/UVl4GaFMj7zTDTSL8MbS0J/2LKASLUMNdB5y6YbBPfyP8G3ZOpPFmj5q/M8sW0wV
         ilJG4VB7U77x8hJ7LvAYcrgW6vtacGTNQJzs6T1K/QG3pey6yfK6fwF+1aapm2TRW9xW
         2VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=617BtXfhDhCxYwKbF1MbJDp6FkHkJ91InZTtwhgrWAc=;
        b=gNHolD3GjHw1jNm4JaBIh2rtJg8/fJzmIjofi10PGdTCQrz8Ed/2ziKCf1mKPvTrGh
         vYcyIgp5JYOKiKL0O4I/nEf8EYj5jPZj63VtSU77CtrsYbZE9uYbikfxiQ6Hb05kjUbt
         Gk2iiczi90/kKmRXVwAvlrdxcHr2IytL4qpkKvG3mOOtVHUsrqoEIFKwZzZmuiQtErRe
         So1jgubMJTl5yKICx7OCDa1Jcf/IsA1XpkMwkhf6n4xcuKqkOyAcEl80JnbYSFfrY1jT
         Yr6WGUS3yeIppMc3412RefCpY+HDwmYd0kUvX/OA364/uUVhtTxvvMqnFqRehb4SC7BR
         snhQ==
X-Gm-Message-State: AOAM531w+vrkCgI7IVkczrFna/FrbVRDFUinQECYSTqSOUX3EYJx+41N
        nSo+d51XN8uKjkBUmdUS9xKkQQ==
X-Google-Smtp-Source: ABdhPJwkB7sITv68w2uhGuGyIEDhJuVxctNfcClDDMcucA+tPHFjkiTXUaT2RW1CffXlgMiXC6FjFQ==
X-Received: by 2002:aa7:97b6:: with SMTP id d22mr1134558pfq.202.1594666292267;
        Mon, 13 Jul 2020 11:51:32 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id t5sm13652413pgl.38.2020.07.13.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 11:51:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel.lezcano@linaro.org, linux-amlogic@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amit.kucheria@linaro.org>,
        lee.jones@linaro.org, amit.kucheria@verdurent.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
Date:   Mon, 13 Jul 2020 11:51:31 -0700
Message-Id: <159466628489.14780.16650652644732625599.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713065931.19845-1-narmstrong@baylibre.com>
References: <20200713065931.19845-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 13 Jul 2020 08:59:31 +0200, Neil Armstrong wrote:
> Add the Khadas MCU node with active FAN thermal nodes for all the
> Khadas VIM3 variants.

Applied, thanks!

[1/1] arm64: dts: meson-khadas-vim3: add Khadas MCU nodes
      commit: cabb1f3827109372dcb80081cc654eb54f997afc

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
