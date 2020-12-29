Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE572E7294
	for <lists+linux-pm@lfdr.de>; Tue, 29 Dec 2020 18:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgL2RVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Dec 2020 12:21:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:6917 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2RVK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Dec 2020 12:21:10 -0500
IronPort-SDR: i+PmgkS09dfN3pKiwtgGflOu6gHVkLiaKFE6e1kXkAUz4LYFV51LIFVGDw4FHvnBg2JPP6q1Lx
 GYL2jFqg1QJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="164228702"
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="164228702"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 09:20:29 -0800
IronPort-SDR: bbvQao6qL7U8CvteIPgd/sWex/DkQoA9L2mdDhXfWsEJaK2TCoW7pYN29a2VKm3GkNla8cSBKI
 rLjhrfXIkAsw==
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="376124749"
Received: from rjwysock-mobl1.ger.corp.intel.com (HELO [10.249.150.176]) ([10.249.150.176])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 09:20:28 -0800
Subject: Re: Commit a365ab6b9df ("Implement the ->adjust_perf() callback")
 causing resume failures
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     srinivas.pandruvada@linux.intel.com, viresh.kumar@linaro.org,
        Linux PM <linux-pm@vger.kernel.org>
References: <c185acb9-c757-bb5e-60df-b18bd85d79b@panix.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <1610e3f7-9699-374d-3375-d421f31fbd98@intel.com>
Date:   Tue, 29 Dec 2020 18:20:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c185acb9-c757-bb5e-60df-b18bd85d79b@panix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/27/2020 4:39 AM, Kenneth R. Crudup wrote:
> My laptop (XPS-13 2-in-1, i7-1065G7 CPU) hibernates just fine with this commit
> in place, but suspends fail, so hard that many times EFI pstore can't finish
> writing out the crash most times (but I attached one that made it OK).
>
> I'm sure you'll need more information, just let me know.

Well, not really.

Please test this patch:

https://patchwork.kernel.org/project/linux-pm/patch/2586979.mvXUDI8C0e@kreacher/

also available as a git commit:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=d77a56dee59ef2f15da63501c50c2c903a36c10b

it should fix the problem.

Thanks for the report!


