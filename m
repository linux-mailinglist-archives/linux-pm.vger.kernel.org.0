Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1863E3E9C
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 06:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhHIECu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 Aug 2021 00:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHIECs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Aug 2021 00:02:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F138C06175F
        for <linux-pm@vger.kernel.org>; Sun,  8 Aug 2021 21:02:27 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so23570226pjn.4
        for <linux-pm@vger.kernel.org>; Sun, 08 Aug 2021 21:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AldQEcLU4Bne5/QfBPbwiq3+rOKR/0YKFPDI7z5qWzM=;
        b=FNfaXUcgjFapEPeJS/coW9Sgr5hM560Gq/sxITmJcpGadngAZXX0UrhUGGU4LJ3z5e
         WsiaIFTg8RBGVlLiLcQ0H12+LAgs2Xmpt611wcg4qoqe0enkc/yl/hh1M1AVdeC+iadI
         WxPQ8siqRHbQ4LXP0NYHNPaddy7Wkj+1fXK0rdxxKi8McucbLzPUE8GciicXCZLCLpJx
         kfPz5G+1GI+kSahLi64QjvW0PeDDFdSm4Nroq8KB1f0fy4O5m9NHeJSMks06IJDhwQen
         R6rpEXZzxHsFCwKr+TUJhs1uyd8PBeWNIZWuaLdDC2FanVNzRmxO7BX2kDUQOrQGpTNQ
         6LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AldQEcLU4Bne5/QfBPbwiq3+rOKR/0YKFPDI7z5qWzM=;
        b=KYDqI8eN6CwwvNIAFi1iZrJVdIFEqDeEw9WhsY6Nb0YY6CZMssoLyCPHi2ZXjTMTmH
         Z91imAncRUVMZ8a6JcJfB4gHCji6bTOyFGFZvsldL394qCUYugcisl7LPT0KKAkML+FG
         DuJtIDYKqWV5C7g88MSGNUP1CVIvCEuTtOa7vU/dSraJI9dOzuIn/+yb9NQrygSVq+oS
         4T9c0bGNrayB4zGP+5n5jPHwy+cPMxfKE5izwsyemlrVEtKbknAdu/ndg6ks1KzxbFlY
         edybiX2MTONWPYgVuJsTTy34cH5htPoSFQwCyLqISGHmyBhb4CSinsbYDAQhYk6Cbe2N
         FVfw==
X-Gm-Message-State: AOAM531SgDuhjgEmh5Mbc3cUAEno8++cN5Ezc7F5T18PhHh0AIENKCe5
        LDvFYi+wvtmfVF8GGoKU7tSTiQ==
X-Google-Smtp-Source: ABdhPJyNZaMk+UNxY9w3x6CwfBpmJrtsgAchn1G88YMHV5tQRbbeqfL5YxG6ZzhKrjgpcBWfvlubqA==
X-Received: by 2002:a17:90a:bd18:: with SMTP id y24mr34173222pjr.83.1628481746909;
        Sun, 08 Aug 2021 21:02:26 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j15sm18005156pfh.194.2021.08.08.21.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 21:02:26 -0700 (PDT)
Date:   Mon, 9 Aug 2021 09:32:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Konstantin Porotchkin <kostap@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>,
        Victor Gu <xigu@marvell.com>, Evan Wang <xswang@marvell.com>,
        Benjamin Huang <gdhuang@marvell.com>,
        Igal Liberman <igall@marvell.com>,
        Jason Hung <jhung@globalscaletechnologies.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        linux-pm@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, nnet <nnet@fastmail.fm>
Subject: Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz
 variant
Message-ID: <20210809040224.j2rvopmmqda3utc5@vireshk-i7>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali>
 <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali>
 <20210808193026.xuyaufi5wqnrcakd@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808193026.xuyaufi5wqnrcakd@pali>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-08-21, 21:30, Pali Rohár wrote:
> Gentle reminder. This is really serious issue. Could you please look at it?
> 
> Adding more MarvellEmbeddedProcessors people to the loop: Evan, Benjamin an Igal

We can not hang forever for something that breaks stuff. Applied this for 5.14
now.

-- 
viresh
