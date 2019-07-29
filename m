Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFD78832
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfG2JUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 05:20:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39788 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfG2JUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 05:20:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so27314513pls.6
        for <linux-pm@vger.kernel.org>; Mon, 29 Jul 2019 02:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3alocEzQkvOwDh436VckIPvqKCkr1/ONfYhyc3HCC6U=;
        b=lP5GqG55Dyw5q7dJRePrFeD4Vo+xWMP9VbWvK9qbiZWztz9sX0u3JEEg9bwi3Qelv/
         K4Bbd4gXh8SI2XTM6SudJHqwrUpriyQVaKkV7Q3w2QBfJs8/ksKNgnNvs8Kq17eqjGwO
         IZkacmtTUtHNlN+nSxwxrtuInYWAaQidOdLLAxd0ULiL+dCihfleLcIWD8iL4SXRSWme
         +Z5O2ciwWgeBg1W61hhEY6T5YtIPR7YzHvKtiZ0AipJOglTfkqdaipfmVVjMudZz4i2O
         6O3PlX4Te4WeGuVUDovJAGSfp0T/xmiChZDDLIjKbsExzEe656X+11lNfimOHjyxlKgy
         eW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3alocEzQkvOwDh436VckIPvqKCkr1/ONfYhyc3HCC6U=;
        b=YJfOZLcD/CB3mpIrW4yAj34EkmwQ7G2/diNZsQiplTxQ7glOrIeVrJAKUigOUESoWt
         EiUNC81kDnXzRN+IjafchRJRNYn0qUkSr3juYAU+ZhBIenHL3HILNBYqogqQbigemyRu
         he+PTfk3wV3BRGbXA20QjzMkJQnirEx2wNIwuXGQVSZWcnEKk5Xi4HBtVXTs9sWtzMjt
         fNO57J/1ASGRHyxNiT2np0e/Samuwvq9Or9Qt+CxvcBOl0Y8l1TndhVPQwvqiclU4YFN
         XaInammbQzSz+6G4jD5e3jkXd8h3g5tnNXCTyxcSPQH9FrQSf2f3ZLyxG+9Nz01TGgr4
         d8/w==
X-Gm-Message-State: APjAAAV1wSilZ9zMfJtXUsj751qiENf0KSTI9EXxL5NoLj/j04VmJwRM
        i6uaPYD97eKZY0O1xXzKyg8xCw==
X-Google-Smtp-Source: APXvYqzKLa/htnlBgwYP5UIMstM9Hmp8PWyPwF3BGDnYJXIAoSflXEa4GnCszC/9bxndDaHastGyKw==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr111071711plb.84.1564392016316;
        Mon, 29 Jul 2019 02:20:16 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id m4sm73215197pgs.71.2019.07.29.02.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:20:15 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:50:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Andrew-sh Cheng =?utf-8?B?KOmEreW8j+WLsyk=?= 
        <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        yt.lee@mediatek.com
Subject: Re: [PATCH 6/8] PM / OPP: Support adjusting OPP voltages at runtime
Message-ID: <20190729092013.5sz2mdqicrit5nta@vireshk-i7>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1557997725-12178-7-git-send-email-andrew-sh.cheng@mediatek.com>
 <20190520044704.unftq6q5vy73z5bo@vireshk-i7>
 <1564371555.18434.11.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564371555.18434.11.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29-07-19, 11:39, Roger Lu wrote:
> Dear Stephen Boyd,
> 
> This patch is derived from [1]. Please kindly shares the suggestion to
> us. Thanks very much.
> 
> [1]: https://lore.kernel.org/patchwork/patch/599279/
> 
> Dear Viresh,
> 
> I followed _opp_set_availability() coding style to refine
> dev_pm_opp_adjust_voltage() from this patch. Is this refinement suitable
> for OPP core? Thanks a lot.

Looks okay from a quick look.

-- 
viresh
