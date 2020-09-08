Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4A261203
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgIHN2o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbgIHLOX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 07:14:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6EEC061798
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 04:13:35 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x123so546573pfc.7
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVsW5/h4oQT6F2Ccs9ZaXWGd8sXTP+0lzm/VdEkOoNU=;
        b=karhH+PgSODWREXm0p54GPAS5fuKpXKJt+8Af39CQ0dmYw1iBiarVafXJpzDWywJmJ
         DIKSvOLWtEqV5fTY4VG41E0KD8ebLBehgL3RGJ7bpbnAf3kVBO4L850CEl8A1aJapJd7
         JQ3QoaevsqfxrykTQpknub/IQdeBSPVV2v1liXvQT2jv+GzKuquHLazpZ/Ra8aAaE5di
         U3EAuJzzwcfDuAfXJ4PkAGDasgeNGCzwoNghhN0Z4N7KoQlb2nuph1iguJVETLTA6O1l
         eVacXWnmpIcXJtfgaNMO215NZqqgddBf552Xa7E+yvy/iBppLvv++FcgttQzzlql+Vxn
         GyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVsW5/h4oQT6F2Ccs9ZaXWGd8sXTP+0lzm/VdEkOoNU=;
        b=tBZDYAhJMfFVyFXOZOxQANP+LZbhbq6DG9OWqNqUlgfWg68WmQpDRNnGfoWot3UIT3
         vulbdZchuBsLM5R/CoIsLIkBw2qD46Z+fJ2WOlwHDDDO3Q9eEKMp2TjbZq6z3kXpGm/P
         MNfF6X8JUuBgvX+LYsOlPl+bAvrbVx9+KjGfgO/yEpnqSYWNKqDv0CpH24iAXlLMhf5o
         dQFXaR7pANPDKj0OTaY6XRnzNNScNWR7Ol4dK+AZEFrC6ypwBnRBGBaXNU04YraCOcJs
         u4FqHDLRYrnGAyhFnD+2g5G6JzPzRDvsiCOO6DYu93Xs4wI9uE0MFDN1AlXUpk9M3dTj
         jI2g==
X-Gm-Message-State: AOAM532YV/pa+7QxwL+tUKKMHWYoMbGzyW39uBjmJnTJ6lSEXRMxZR5T
        kt59acs+F9YWqjKk1QXGc1Ictg==
X-Google-Smtp-Source: ABdhPJx8styTZ/vn74fTMnB2guiXpmFzAePJU+SGLWP0r0xJfiKvSMVi9vEJfHQyKmPs/jo/hm/Hnw==
X-Received: by 2002:a17:902:c3d3:: with SMTP id j19mr23528672plj.59.1599563615251;
        Tue, 08 Sep 2020 04:13:35 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id q18sm13906333pfg.158.2020.09.08.04.13.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 04:13:34 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:43:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v4 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200908111331.rdvtrvttoapqxaib@vireshk-i7>
References: <1599550547-27767-1-git-send-email-hector.yuan@mediatek.com>
 <1599550547-27767-2-git-send-email-hector.yuan@mediatek.com>
 <20200908102752.r2n6xvghl4fcdrcv@vireshk-i7>
 <1599563425.2621.5.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599563425.2621.5.camel@mtkswgap22>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 19:10, Hector Yuan wrote:
> OK, I will define the corresponding exit function. 

Also please add remove() corresponding to probe().

-- 
viresh
