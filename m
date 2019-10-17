Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5DDB27C
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408251AbfJQQfn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 12:35:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403818AbfJQQfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 12:35:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so1995771pfe.5
        for <linux-pm@vger.kernel.org>; Thu, 17 Oct 2019 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=n6iC9aFIm7u0dU/zNM/QcsEIHkk1HFiJjgCYQoT2Mo4=;
        b=rLw/zBLGb832jZnhC2XQDPu8GmL2TDqIyAqgKiHS1bkVHYZkpv31ojFkQe9yoiJosu
         OATsID2jjJR5fxB+f27xypsvogvi6NjOdJuEY7WyxCWVO7QiPmERQP2+3LNeZNHKeyYy
         U22+IPML7CXzC6MXwg06aYBKwbQvWV1aigUizyhhQR+EVGzHw+1AhnxJoW8lCCKcuziZ
         eCRAX7bq4dZl7sJRffrCj8kB0V6/MnbvHkNqZ1ZUfVoC4MD5M4rHy2E4APOoapoH4CAg
         2xNy2mueNekGx0CHPQDYJUVPgXpm0OnuDNHVMnK6kDtFcEwWHo03utLEe0wjkTK/Sp3/
         oztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n6iC9aFIm7u0dU/zNM/QcsEIHkk1HFiJjgCYQoT2Mo4=;
        b=Gu/lgz9zeZH6lX7zm5Mj2fvPWTpp1oedY9MTWDH9VGFO7uHdAjJ91l30TxtHQNfppE
         Efcml7HS5YPfFHDb6JSVaHXAtXRzAaAQ0ShGFScfkQNDgEmAiYI44vdw7uuk2UVqn08s
         DqIMWMU2pWd16TSKJfEh7r9FuP96ZDsTCvO+JZImmrmxwTzyfZVJ3T5gLZ7bbUZdpU9R
         Y5zURjslvo8/w/U7ReQVKpsIJrk35Vnq5ZqtX0d0fowFrUcV8G9GMCbM4YsvBj8yQ8Z+
         G4PcSu7Qz9FvQa4PuqZU15Tb0/EQAemBMicvtJ9fS+q1iSeAIpNYC1QUSJOipJuGZrM+
         RPpQ==
X-Gm-Message-State: APjAAAV5sKVo8Cdtsm1SlFSfZ6v6S1w1fszEVT83AQ1mSkvW4sXaxTxP
        42dX+JsRjf8wCKgTkJR1neBufQ==
X-Google-Smtp-Source: APXvYqx8QHZBP4DAVpyoFFyUNQRbXJjtCE3kG8SFGsa5w0UJekNJKz/9aCD9K0RXSuH2lXuA6W7rnQ==
X-Received: by 2002:a63:82:: with SMTP id 124mr5391099pga.112.1571330142686;
        Thu, 17 Oct 2019 09:35:42 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:d8f2:392e:5b44:157d])
        by smtp.gmail.com with ESMTPSA id j10sm3548870pfn.128.2019.10.17.09.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 09:35:41 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        amit.kucheria@linaro.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v7 4/7] arm64: dts: meson: g12: Add minimal thermal zone
In-Reply-To: <7hsgnsfxpx.fsf@baylibre.com>
References: <20191004090114.30694-1-glaroque@baylibre.com> <20191004090114.30694-5-glaroque@baylibre.com> <7hsgnsfxpx.fsf@baylibre.com>
Date:   Thu, 17 Oct 2019 09:35:41 -0700
Message-ID: <7ho8yfba8y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Kevin Hilman <khilman@baylibre.com> writes:

> Guillaume La Roque <glaroque@baylibre.com> writes:
>
>> Add minimal thermal zone for two temperature sensor
>> One is located close to the DDR and the other one is
>> located close to the PLLs (between the CPU and GPU)
>
> nit: subject should be "arm64: dts: amlogic" (not meson).
>
> I fixed it up when applying,

I got it backwards, this one was right, the other ones with "amlogic"
should be "meson". I (re)fixed it in my 'v5.5/dt64' branch.

Kevin
