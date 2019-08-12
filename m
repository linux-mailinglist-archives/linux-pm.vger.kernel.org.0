Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D13189D54
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfHLLvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 07:51:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33129 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbfHLLvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 07:51:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so10680206wme.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2019 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RBO3DRjOTnD2wLqgKm2sOWPkxUiw82Gd++GtZ0/46Pk=;
        b=nz/9gOYBm5f41AVteysD7l24n/Fd0CiOd3001w0L8BtaHes0R2oAL3pINo1E67hDqy
         LYLZYDx2CxxVwMBSRwITxQ7LBANizanIV8XLQDJPMvsJ77m9tES+HS7jSPuaZNNf5zLH
         nJNC3fbaSgk6TIwPbEkvXAR9YMr4uaJGNyujl8nkgLPC2ajuplKaJMLBVMygaRw4mctr
         v9K4EXL7KXzp3RsqZvOuNFZZIBgL3EH8ok18K9QCfbZD0XeauBkGNU8sGb/rdBD+mhii
         VoucQhke9qSJVeBDCh/U7CT6nQl1GGi3bHOV9kBWWjJvjTkOKetcXv8rzrMZAI1jwibq
         JScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RBO3DRjOTnD2wLqgKm2sOWPkxUiw82Gd++GtZ0/46Pk=;
        b=Ac2w+NEQoS9PxxIz79WOc57j+5aDv6bdxtHzgil7vze7OFMRXXuu/ESSXSookiSV0L
         RB2HwXZm1E8pX6rnDhWMb+U53fObLExefNwIlTsMrywryuQNYEDwqhhbVd+c++OG13zi
         TiaBFG+McK/D6bja5zNxbCk5bJwa3pvG7xa/68XJXIv8XcyAgAJmriXYYUZDqdfiun7e
         zfO4yaan4AFAU1zLhidm/LLaVw+v2RXjnS6lRXfvSYRhwNIrjhwumYdcYj+HTM88NdO7
         PdxeYKKsiJVvhYyHt7rBjeHsdy1udi68hg5/nPe+HGrrD0To0JoXeXsZSqVzVgmhCKUU
         UVfg==
X-Gm-Message-State: APjAAAW18n31y110JI/PKIBeWxoIGAG9tWjJ0eidNDa2u1qu0wpQBFrr
        u4evVhBYAglNTwJRAjtMs/k6yw==
X-Google-Smtp-Source: APXvYqwV9aoRqyXcZZQN5vuglpU7Un+RzXUmxodwxoqrNtY4ZzQnftXwr2r3/ozL4duHxbq6J6RM+w==
X-Received: by 2002:a1c:a985:: with SMTP id s127mr26790055wme.163.1565610711038;
        Mon, 12 Aug 2019 04:51:51 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id s64sm22246982wmf.16.2019.08.12.04.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 04:51:50 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:51:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Eddie Huang <eddie.huang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Richard Fontana <rfontana@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Tianping . Fang" <tianping.fang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>
Subject: Re: Re: Re: [PATCH v3 01/10] dt-bindings: add powercontroller
Message-ID: <20190812115148.GT26727@dell>
References: <20190729174154.4335-1-frank-w@public-files.de>
 <20190729174154.4335-2-frank-w@public-files.de>
 <20190812102035.GH26727@dell>
 <trinity-a6c06411-16d3-40ab-a4fb-3494131c8ed6-1565608221532@3c-app-gmx-bs80>
 <20190812112507.GR26727@dell>
 <trinity-738d59ed-ecac-4025-a729-0888eaea1f95-1565609875829@3c-app-gmx-bs80>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <trinity-738d59ed-ecac-4025-a729-0888eaea1f95-1565609875829@3c-app-gmx-bs80>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 12 Aug 2019, Frank Wunderlich wrote:

> > Gesendet: Montag, 12. August 2019 um 13:25 Uhr
> > Von: "Lee Jones" <lee.jones@linaro.org>
> > It was an example (hence the "E.g.").
> >
> > You will need to adapt it depending on where the file ends up.
> 
> i saw the e.g., but i wanted to know relative to which directory ;) your example mentions that it should contain the dt-bindings-folder and i think it should be relative to current file...
> 
> have applied your suggestions to my tree
> 
> https://github.com/frank-w/BPI-R2-4.14/commits/5.3-poweroff
> 
> please take a short look if i don't miss anything

Just resubmit them.  Doing off-list reviews is a slippery slope.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
