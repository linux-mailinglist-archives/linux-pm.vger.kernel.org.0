Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB9ED97B0
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 18:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390911AbfJPQmy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 12:42:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33778 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406426AbfJPQmx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 12:42:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id d22so11538034pls.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2019 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=57uyxmoXhyIZG8+XPLz4fjpdkC+Q+fEOX17k+/hG6tY=;
        b=rUVvtmAdciiJfC7zc4iHMpw0uFh5wPbykASFgtkhhw4m6QvnfcyqH34IwbX3rt2paY
         S5eDisYcUokzkMN0ZlmKCeGbkDuF9ZpAO+PqcB9/zZacqIJvpbgiEQZKMVUEVyA5zNlz
         dkXXvQ867OpBmcb0Txd1GiCGy3r8/dK57xR4mNDDpRLHNaO0SM81tF4UH5eF5Kx8uQUY
         5E9cNIQMD0zJdPtVFt7+OEY2+ZJCDurQ07h3cRCzwpA59yudNtwCCW7htiobEkO5+sKy
         BY5woMUym4gpM5RN5h0C6g9T/oPCjR13uI5ktka4HojeQajPoJZHgLzDzzCLXmqZOtw9
         12jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=57uyxmoXhyIZG8+XPLz4fjpdkC+Q+fEOX17k+/hG6tY=;
        b=nUqRSGF67GsvSp2fzim3Jwy0NIuJqvjwNDsR/0ffd6ueZgsGKJ/+CIVD0gKrmgQz7A
         DyvSi/zhvvE7e3x2ZS0Awlu58USAaXUL6IFi00f9jZeEO1JPA4XnWKQ3p6FT6YMkbduA
         9jIW0xv9BC6CyThD6KQSyA/Uxon0rAMGG33Sk6fDGQFc4tVWpKDu84tKNHzLlRHb313R
         CMazKxEcufa6pxDh52n4WXPYLT2drWazPSEtCPAfKQABXWbfOZ2d7E9HRdUKTRK5gaHT
         53SwAMPQmDMJOI4NNeqs/4J2A63iXvbcDLNeATHqQYsyg6mkFFZaBwNRnDXRj7sWHICU
         FK6Q==
X-Gm-Message-State: APjAAAWJ+XS0+LJe5E16lBte6ChdqNUWQdgJGE98AQl3rM9vhUE8LrNP
        TRY3EIV8YP+n6G/xD0tOEcfC1A==
X-Google-Smtp-Source: APXvYqzYGefqM+N97RnNolUGlVbbJgqvYENkUacnJagIFtdqHenQ0FP2dvlvfgAmmN8wCkoVChDPiQ==
X-Received: by 2002:a17:902:8505:: with SMTP id bj5mr6102750plb.31.1571244171732;
        Wed, 16 Oct 2019 09:42:51 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n23sm23363431pff.137.2019.10.16.09.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Oct 2019 09:42:51 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
In-Reply-To: <20191004090114.30694-5-glaroque@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-5-glaroque@baylibre.com>
Date:   Wed, 16 Oct 2019 09:42:50 -0700
Message-ID: <7hsgnsfxpx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Add minimal thermal zone for two temperature sensor
> One is located close to the DDR and the other one is
> located close to the PLLs (between the CPU and GPU)

nit: subject should be "arm64: dts: amlogic" (not meson).

I fixed it up when applying,

Kevin
