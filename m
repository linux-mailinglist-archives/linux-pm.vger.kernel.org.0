Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 691C3A0A61
	for <lists+linux-pm@lfdr.de>; Wed, 28 Aug 2019 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfH1TWP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 28 Aug 2019 15:22:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46430 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfH1TWP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 15:22:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so390596pfc.13
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OHL9VW/pbZgbjy6X0oW/1YciHsupykYOfcE3lMTyhrs=;
        b=fph7hjw0oI0ISbpc1+PlmQdPBZe2b3jdllI7bz13paCCNa09LOWtZVy/rtz/FyI384
         N9yxwotr7jdU+JskFlaXdVKHUnFZzNY3MN60S3W6Nn/v9zJCiNX6azDUrivXsAnXnrKw
         oZanxW4wIIcRAKdfDyd5OyK7o34IbTaREG0uxVzGWbmzL83F26j0kk8jqGFzu9MN+UCM
         70leIzib0AylP8YdY1newKSzBZK6NlTYw8MfMseqZKqxvAlTcZdZONCZ0FnzwMEY3uK5
         h70ku4+Ao6Fls0yIbheZ23ptrU5VBhsHjGk1j61MB2vmm1sPiMrjK1XGYX4lvNCTreUT
         ppbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OHL9VW/pbZgbjy6X0oW/1YciHsupykYOfcE3lMTyhrs=;
        b=hoaSfemxH1OAmnuRrRqDiLwYuCG1K2opeVu4on/AXegbOy1cnGcPLg/605c9GwwL79
         1QSNH5cMwpL8rpjTl86Hw/W0LwAhQRP6lTOodYNO4dO70+E3VFk12H0D5k2mPzISJDxV
         OsC6O8Dxfpaul6VVeOo56d8H9Kk65OyBg/XSWzmWvtbXbssCAvkeQRD9fV1yAGL+ABse
         4AOeQqLiGbomMrPoNUoyLW9Gzt3lT/Ly3ZNds1lZJV7jFZMCIUVeQ9mKcZxj3pb0+SeB
         t6JrVUKRBV0JbIWgclSMxLNoS+wJKsTIor6foP6JV5iArjjKbQDHDpi1H9vf6k09fk9W
         NoAA==
X-Gm-Message-State: APjAAAXR9/ozKyhy8h5ORLuflYsd4Qfeh+1RpjWEwRISTc3C96iICQbR
        QyUYhHG/w3mOpuFDDHsbB8J45gM2gMY=
X-Google-Smtp-Source: APXvYqxVwWGCMgMVB9QBnkOEoSoOuiImGY1cZU65dtq+4tFmWwT/jaRS6aCujF2eBPDab7uA7/7A/g==
X-Received: by 2002:a65:6458:: with SMTP id s24mr4793968pgv.158.1567020134686;
        Wed, 28 Aug 2019 12:22:14 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x17sm125380pff.62.2019.08.28.12.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 12:22:13 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:22:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     qualcomm-lt@lists.linaro.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, rnayak@codeaurora.org
Subject: Re: [PATCH 3/4] thermal: qcom: Add RPMHPD cooling device driver.
Message-ID: <20190828192211.GO6167@minitux>
References: <1565398727-23090-1-git-send-email-thara.gopinath@linaro.org>
 <1565398727-23090-4-git-send-email-thara.gopinath@linaro.org>
 <20190824061029.GT26807@tuxbook-pro>
 <5D650904.1010402@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D650904.1010402@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 27 Aug 03:42 PDT 2019, Thara Gopinath wrote:

> On 08/24/2019 02:10 AM, Bjorn Andersson wrote:
> > On Fri 09 Aug 17:58 PDT 2019, Thara Gopinath wrote:
> > 
> >> The MX power domain in RPMH can be used to warm the
> >> the SoC in SDM845. To support this feature, introduce
> >> a RPMH power domain cooling device driver that can be
> >> plugged into the thermal framework.(The thermal framework
> >> itself requires further modifiction to support a warming
> >> device in place of a cooling device. Those extensions are
> >> not introduced in this patch series).
> >>
> > 
> > This cooling device provides an interface to set a minimum state for a
> > power domain.  So while it's used for controlling the MX rail exposed by
> > the RPMh on some Qualcomm SoCs there's nothing Qualcomm/RPMh specific
> > with it.
> Hi Bjorn,
> 
> I agree that there is nothing Qualcomm specific. Are you suggesting a
> more generic driver here ?
> 

Yes, that's what I'm suggesting.

Regards,
Bjorn
