Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759492E7341
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 20:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgL2Tnw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 14:43:52 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:52268 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgL2Tnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Dec 2020 14:43:52 -0500
X-Greylist: delayed 1024 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2020 14:43:51 EST
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
        by l2mail1.panix.com (Postfix) with ESMTPS id 4D54D809pYzDb4
        for <linux-pm@vger.kernel.org>; Tue, 29 Dec 2020 14:26:48 -0500 (EST)
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 4D54CF2LMmzcxW;
        Tue, 29 Dec 2020 14:26:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
        t=1609269961; bh=YuDR3oR9ds7BGcOolspYlsyhFs9YRk2+h3sc8xIwDS8=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=KMYMfzvf3cjP6E5/Ko98hCQhNG3XFTqmMZmFKdf1YwVxZw9y+gLV2nBcmu0o5RCTB
         Uplroa3iYBlf5R5HAJi5LNNaH6J9rwlbcGwvL/RFTl2+uyhFlgakAVXIbYRXgaSif7
         xur/1SU1wv1ow9rCvS0/Qs/K5QGqXXUrJRBuMYtg=
Date:   Tue, 29 Dec 2020 11:26:00 -0800 (PST)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
cc:     srinivas.pandruvada@linux.intel.com, viresh.kumar@linaro.org,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Commit a365ab6b9df ("Implement the ->adjust_perf() callback")
 causing resume failures
In-Reply-To: <1610e3f7-9699-374d-3375-d421f31fbd98@intel.com>
Message-ID: <15c31b73-83d1-39b5-3652-b9435a5cd658@panix.com>
References: <c185acb9-c757-bb5e-60df-b18bd85d79b@panix.com> <1610e3f7-9699-374d-3375-d421f31fbd98@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On Tue, 29 Dec 2020, Rafael J. Wysocki wrote:

> Please test this patch:
> https://patchwork.kernel.org/project/linux-pm/patch/2586979.mvXUDI8C0e@kreacher/

Fixes this issue- thanks!

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
