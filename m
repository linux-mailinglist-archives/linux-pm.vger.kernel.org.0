Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF87E5A6C
	for <lists+linux-pm@lfdr.de>; Wed,  8 Nov 2023 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKHPqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Nov 2023 10:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjKHPqk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Nov 2023 10:46:40 -0500
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD171FE9
        for <linux-pm@vger.kernel.org>; Wed,  8 Nov 2023 07:46:37 -0800 (PST)
Received: from xps-9320.lan (kenny-tx.gotdns.com [162.196.229.233])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4SQTwD1xCczss3;
        Wed,  8 Nov 2023 10:46:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1699458397; bh=Z+S/BIuxQphcdHkfTjcRpAnZddILcgQsHqzNiHPMS+8=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=oADR80MlSvTas/qxNmEqrTx1+09lVux74Tiw3iABvdka7Oh03bFlCSSClLL+eIQ95
         qOCycIj3Mx3CuaiC3npp1M5kLktOGXEhwZB4lSmSAvWqWPADcB3ofXBfF+FkL1oO4N
         SlUoTAYBNLen9YROc6OLVxh6Qo7cXyjJcW7DEpUc=
Date:   Wed, 8 Nov 2023 07:46:35 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     vidyas@nvidia.com, bhelgaas@google.com, andrea.righi@canonical.com,
        vicamo.yang@canonical.com, linux-pm@vger.kernel.org
Subject: Re: My AlderLake Dell (XPS-9320) needs these patches to get full
 standby/low-power modes
In-Reply-To: <CAAd53p5+WaHCDav_3yLBg9mJiyi6saQiXTqx35nqZte=0mM-pA@mail.gmail.com>
Message-ID: <b0e16288-bfb-a2fe-d8b-49e1e457f082@panix.com>
References: <218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com> <CAAd53p5+WaHCDav_3yLBg9mJiyi6saQiXTqx35nqZte=0mM-pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Wed, 8 Nov 2023, Kai-Heng Feng wrote:

> I am working on this, hopefully I can come up with an upstream worthy
> patch soon.

Thanks, everyone. Let me know if there's anything I can/should do to help.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
