Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8649F093
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfH0QqO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 12:46:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36352 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfH0QqO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 12:46:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id n1so15485856oic.3;
        Tue, 27 Aug 2019 09:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lM2LSGOVkJcZtWFfD5Jdwg0IHy7hecaVTT/aMqFXwU=;
        b=nKXsdg5TIHrXkM6l01d/7j+XAncTIpe0IyibscPhvC/ibDY2pAN2GiQIwGvaHiP4LU
         Tuz+fY0cBnZfNHaBXo7krdHzDOEFOsgGM3PHLhLZ0HznVf8tt6nBretoLOiOlRcEbXJp
         6HKisu0kMxvLyCLXIv0tGKzHOjR/PWTq2TM2VtiFXqi0S3/+e9O8RPJS5GaDatzSeIF6
         uhSIsB/a5QMPX4sxGF5lfmK/MQrL6oSSobCPbd4LGKkr4SGNdvTnqozKv6WWwhoN6y8a
         yN+j5btVNy154D7BNwwmoYd/77PduBphIJc4RjanMCVgGrmY/jAazHLbnIQWeCT0qWSw
         QChQ==
X-Gm-Message-State: APjAAAXhTuvfx1zXcoujIOM9OdyRGZTjki4qPYu5mO4GHsI5ZeK11OjY
        xjqZVF663HpsUdMA9fBKmg==
X-Google-Smtp-Source: APXvYqy/7mhHBbKaDA0gXbeIS7o/GWKkWjXh2VhvxIQBONNcesOLPhf4YOZcCD9RmMJGg4w0JY1Pkw==
X-Received: by 2002:aca:4f07:: with SMTP id d7mr17082181oib.70.1566924373339;
        Tue, 27 Aug 2019 09:46:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t23sm4500156otc.59.2019.08.27.09.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:46:12 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:46:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        devicetree@vger.kernel.org,
        "linux-arm-kernel @ lists . infradead . org Alessandro Zummo" 
        <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Subject: Re: [PATCH v6 02/13] dt-bindings: mfd: mediatek: update rtc to
 include mt6323
Message-ID: <20190827164612.GA18496@bogus>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-3-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-3-frank-w@public-files.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019 15:56:00 +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> add mt6323 to rtc-bindings
> 
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> changes since v5: splitted from "dt-bindings: add powercontroller"
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
