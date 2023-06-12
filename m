Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C1772CD7D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 20:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbjFLSHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbjFLSHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 14:07:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E8E63
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686593258; x=1718129258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vK8jh8zc/sypr4SZSK2EKmnyQeUkihDWqoU8yjTvu7I=;
  b=ZE+Vj7a9Q2dFcNCLs84x+yPrEnF++LI0yWiqvWuUDor1M+CV9b2niGZZ
   misrW9DLO1ka+xFEthf8+5KhsMrgqdNDtfN/KhR9dn3iCctFX/4PHdVIV
   cnuPROWUf8OGFW5gQRpOvq1TIpmIv9JqCIEZct+4sEpVnxT6oPrVVfbqn
   Sfx8MQ8wo8ehe22YzITOGmLaEvKLeIBazbEO9XG414vWGkJp4N9FT6P8k
   F6ipgMYs9t4KU1VURmt+sCIHV/kIz8CDeDCgbC6mfqkcvIN2AnXy/wcEN
   DqDUHOPvKEV24f8vzIe5oNK5asyB3UNDPprEu4m9ctBrp59jf1Q5BMNdC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="347776132"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="347776132"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 11:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="1041442299"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="1041442299"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.209.87.108]) ([10.209.87.108])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 11:07:34 -0700
Message-ID: <64424bbe-eb58-219a-27ad-f8d9b40a0df5@linux.intel.com>
Date:   Mon, 12 Jun 2023 11:07:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] intel_idle: Add support for using intel_idle in a VM
 guest using just hlt
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, artem.bityutskiy@linux.intel.com
References: <20230605154716.840930-1-arjan@linux.intel.com>
 <20230605154716.840930-4-arjan@linux.intel.com>
 <CAJZ5v0hzyxEqvGUNAnk42qR-qeXc9+cD-HyTGF5mm=n65cTDbQ@mail.gmail.com>
Content-Language: en-US
From:   Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <CAJZ5v0hzyxEqvGUNAnk42qR-qeXc9+cD-HyTGF5mm=n65cTDbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/12/2023 11:05 AM, Rafael J. Wysocki wrote:
> Since true is returned by default below, why are the above checks
> necessary (or even useful for that matter)?

they are really for documentation purposes to show all cases are handled... but if you hate them
I don't mind them going away; I can respin quickly or send another
patch to remove them.. up to you

