Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663239F09A
	for <lists+linux-pm@lfdr.de>; Tue, 27 Aug 2019 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH0Qqr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Aug 2019 12:46:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41694 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfH0Qqq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Aug 2019 12:46:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id o101so19283708ota.8;
        Tue, 27 Aug 2019 09:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CAs2n7SclDasXH/YTuCcEDQMrDZ4XPV6SQOQ30cxB3c=;
        b=DCwA5xn5Z5ey7xz8RLeT7wrX3Ze2/N973tLIb6EbenW8dpMs1jaux9nRAseDxzTc5V
         gC6k9ul3U9yPzvfa/8E0k00+eeJ2UQsCqFZydzroKYykdgI4ozze9GuuvOsZfRQuVsjI
         X1cfPwl7UmfPNGfOkhVFq3X1X7puFx4kVn/KpwAmNp0K9XuO62EIXhNFxBlPULG84m/y
         jXHMNH9Ez/KGAQsWWtrz3B265YQc63NsrdL/6XZPcNbzyJ+H3z5FBy/0MvF1Oa4yPzWq
         i1VAtfYwH3ZsUscfapbOwmvasyy415dJxgMBpH37CKCaYhoEK4F1FBuaxKKl0vDlvGFP
         Qyqg==
X-Gm-Message-State: APjAAAWBZsHmRkIa82Uf7OqfwzfqZNjko7Y0/GsxiZrzclvVbX+RoeuV
        6Ah6TqlCStfVXjJeBORP0w==
X-Google-Smtp-Source: APXvYqzuEJQJrMAivNxLfrtCAmfyFVGBZhbSzA6c5euG17Aeg9Gel/VVfy/vMk7qKzoZhH7WIZ5MxA==
X-Received: by 2002:a05:6830:10c7:: with SMTP id z7mr20810935oto.243.1566924405681;
        Tue, 27 Aug 2019 09:46:45 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t23sm4500955otc.59.2019.08.27.09.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:46:45 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:46:44 -0500
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
Subject: Re: [PATCH v6 03/13] dt-bindings: mfd: mediatek: add mt6323
 power-controller
Message-ID: <20190827164644.GA19437@bogus>
References: <20190818135611.7776-1-frank-w@public-files.de>
 <20190818135611.7776-4-frank-w@public-files.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818135611.7776-4-frank-w@public-files.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 18 Aug 2019 15:56:01 +0200, Frank Wunderlich wrote:
> From: Josef Friedl <josef.friedl@speed.at>
> 
> - add powercontroller-section to existing binding-document
> - add mt6323-pwrc bindings-document with example
> 
> Suggested-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Josef Friedl <josef.friedl@speed.at>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> changes since v5: split out non-pwrc related changes
> changes since v4: none
> changes since v3: none
> changes since v2: none (=v2 part 7)
> ---
>  .../devicetree/bindings/mfd/mt6397.txt        |  6 ++++++
>  .../bindings/power/reset/mt6323-poweroff.txt  | 20 +++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-poweroff.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
