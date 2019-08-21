Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B6A987FF
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2019 01:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbfHUXki (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Aug 2019 19:40:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45608 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbfHUXki (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2019 19:40:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so2226646plr.12
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2019 16:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=PdGmstYjj4UcbwNUp869OtVuxov1WvQjhoAxWHt7vJo=;
        b=mzfyNIBHNRCTGRIjuIu6tTYOToZwmVVnG633lROYmZz407Fg369qEh433GRk9g46qr
         qZET8vlULsVr/1I0eG4WGKcI+worE3kCeP24qFF+KIORfCcaQs8wyob4PbLoMIm1XpDf
         WanKKGUVelZOnpW4sKm+nFUXJMthRLptAYWZmioldfobL4WbEeKjQzxZq4uhY3SxNFuD
         N3vUAk0TwaNsSApmgBV3FFc/UXPQrBiGaG02+d+yUDGbCdSRiN8TghsG86TSNeadztFI
         cT9z4ZPH3G821E42COUqMezutD91ivm1ulCeE0SkybxPehAzaryyXVVOA6mOBtYcSZOu
         pVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PdGmstYjj4UcbwNUp869OtVuxov1WvQjhoAxWHt7vJo=;
        b=REMvhZQHQZwg9BGer1b139t/HFeOcLRlKC4fLwSu2MB+qJi9NKEgOJvATztTU4eI5W
         S3lVSNEU+amW4hR4O2PLJpzLuzVMmGEMCHTc3hVfyhORb30RdxT04wDH++HJ4QtKmFIW
         pZAogNvMZaXjlSk6YTADhrx8MwdbBybsCMC7nyRB/KhVLoFWDvHeISLcb8sFditgO6rr
         MZupLxUjXTIpc7FlfJMObVckeVoSc8sTnW+IHRkOCuq2NufPS4fw53YTPFUWDd4GKTTU
         FoAQYnkdGZRM4X0iCI13QILFTYi35ZpHBMLup4/unwj76Op8BazkX1Fw9Cd+1y3nbEdz
         0+pw==
X-Gm-Message-State: APjAAAXrO7EsbPL+WB0T4SEeKwZWvLwSnXV7P03UxGth652Z4c9bpUTc
        /QYXItD6bxWCA7R9luEFjnKNgQ==
X-Google-Smtp-Source: APXvYqzBpl28fBuk/sy46hFZ1+kwlWBC/dMV3X0jeBb3i46IAc+BgSafaFw9tf/2hKy8B3vf8N/ceQ==
X-Received: by 2002:a17:902:e592:: with SMTP id cl18mr5064788plb.291.1566430837336;
        Wed, 21 Aug 2019 16:40:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id e17sm1122052pjt.6.2019.08.21.16.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Aug 2019 16:40:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>, rui.zhang@intel.com,
        edubezval@gmail.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v4 1/6] dt-bindings: thermal: Add DT bindings documentation for Amlogic Thermal
In-Reply-To: <20190821222421.30242-2-glaroque@baylibre.com>
References: <20190821222421.30242-1-glaroque@baylibre.com> <20190821222421.30242-2-glaroque@baylibre.com>
Date:   Wed, 21 Aug 2019 16:40:35 -0700
Message-ID: <7hef1e5bpo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Guillaume La Roque <glaroque@baylibre.com> writes:

> Adding the devicetree binding documentation for the Amlogic temperature
> sensor found in the Amlogic Meson G12 SoCs.
> the G12A  and G12B SoCs are supported.
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

nit: put your sign-off at the end.  The tags you collect from
reviewers/testers should go first.

Kevin
