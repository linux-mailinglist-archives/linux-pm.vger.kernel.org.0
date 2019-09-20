Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAE9B997A
	for <lists+linux-pm@lfdr.de>; Sat, 21 Sep 2019 00:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfITWGy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Sep 2019 18:06:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42358 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfITWGy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Sep 2019 18:06:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id z12so4577301pgp.9
        for <linux-pm@vger.kernel.org>; Fri, 20 Sep 2019 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=keJKsM9t+Xigd272OZzAyt226ZPdGo/jAWLvUfQ5wNg=;
        b=PDmNZgbiTd6S/mK/lf1xKNhWO0cvcN5mV/7OrKAcwgswsVjtZO/yP5Rxa4WR8ULprf
         9LYMu/N7i83y68aLVXTkYKt6FWU+ZXTvxSkjGQiOuG84tTbEugIBbmhdeGSBXJZl8Ln2
         /AGFgzojhIFiHJ98HXwuAteqHhtnP4WJiKFZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=keJKsM9t+Xigd272OZzAyt226ZPdGo/jAWLvUfQ5wNg=;
        b=a12jqyji7rJY9yDeqVwqOeR2t6ZT1dDHYOEXuAIO8hY6MbqQukG7jihXOH3KaaXu76
         qxZ8Bv01s6cd57ewMTyqTgLUXO1Afa89qIcxxgf/JqUOviDsceeUsBAWXdmL0KP5R52e
         998W2fORt7ajAlVf0mRvew+laDu9Smqi9sSIqI5Xysu5H5VpHTdCIMuDajP29BrsULv2
         XqBn6MYS1OHk+VvnnnK4py/064SfLyE65knKEX62voRyl7Mu9LSGbO8kr/vtwXIDQyeU
         6iheRp0zbOkZ+vP31rpdmI0ITMGkFoDFdHvLHxmlLXMA3uJQhWtdzckQw+bIFkc+yLPC
         7L2g==
X-Gm-Message-State: APjAAAWB12zPo/0wtTxQlrPoRMNRRx6gWwyi2xAb3ahZdoyKdl6fomd9
        wo7iR4++mdEWfOC4c6rNSwwF5czkFHI=
X-Google-Smtp-Source: APXvYqzqp81x+edwioSnkLtQmLPvjwAP5YqR7sWHghyWn8edm5LRXIdWACjo8diBzbx3My46M/XTdw==
X-Received: by 2002:a17:90a:3d08:: with SMTP id h8mr7295943pjc.12.1569017212156;
        Fri, 20 Sep 2019 15:06:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w65sm3624680pfb.106.2019.09.20.15.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 15:06:51 -0700 (PDT)
Message-ID: <5d854d7b.1c69fb81.8a4b3.9784@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bab194b89c269f4ab47fecf8292455476fdef604.1569015835.git.amit.kucheria@linaro.org>
References: <cover.1569015835.git.amit.kucheria@linaro.org> <bab194b89c269f4ab47fecf8292455476fdef604.1569015835.git.amit.kucheria@linaro.org>
Cc:     linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v4 15/15] drivers: thermal: tsens: Add interrupt support
User-Agent: alot/0.8.1
Date:   Fri, 20 Sep 2019 15:06:50 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-09-20 14:52:30)
> Depending on the IP version, TSENS supports upper, lower and critical
> threshold interrupts. We only add support for upper and lower threshold
> interrupts for now.
>=20
> TSENSv2 has an irq [status|clear|mask] bit tuple for each sensor while
> earlier versions only have a single bit per sensor to denote status and
> clear. These differences are handled transparently by the interrupt
> handler. At each interrupt, we reprogram the new upper and lower threshold
> in the .set_trip callback.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

