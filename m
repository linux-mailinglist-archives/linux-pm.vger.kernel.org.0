Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0A18F83
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2019 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfEIRno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 May 2019 13:43:44 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36653 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbfEIRno (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 May 2019 13:43:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 744E31691A;
        Thu,  9 May 2019 13:43:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 09 May 2019 13:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mFDG90
        yq4F2EnWFF1ZS80ux8BXFvjcThICBapXjtjfk=; b=JkDquylzTNP+K6EFu6O2B2
        j5Ln2AzammWx0qPNjWIGBiL+UEh8Wa28ad4ebNoQJBL0uajcHLDFIGo2zsAmXsqY
        mIUJW2d0h8SMoeqbJsPz/fU9ARL55uX/6rw1Y9oFQLlKnUPNdxcnlcLrnzSv6a5F
        TSTybgQ4ugXUMrWnnpdBrmNGe0boE1ukxaUczYEFeivnMtxIEGRWj+8PsiN1Dl21
        KvjFU5UwhLYXBAYpkthmyOR+6ly/YGYa5588CRNtiR/TeIjOiMOs4ShsPzePuh0u
        lCiQqTv0sZET1AcaCwewG6EmZ4N0SS0lIQDdLU6ZiV/oicLw3BBb51YvRo7nI2OQ
        ==
X-ME-Sender: <xms:zWbUXFREvd9H9QOQNGYk54OvDXquwI5sgfryfmXjjbiGlkK7pYy1JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeeigdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucfkphepuddtle
    drieehrdeffedrudeftdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehi
    ughoshgthhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:zWbUXJPeqVfufUxXoIV-7kTnS3BRObVeoUZjhyGKnxNsr7S5Rl1N1g>
    <xmx:zWbUXLQE-bsINC6iyqM-QUk9HJe9PdjtdVEXY8X-JjWhoCKhDd2KCA>
    <xmx:zWbUXPNyeWU0h0Drq_C9ULOb_3fAk064Qa1SAh7dchXOaV6IvoKrrg>
    <xmx:z2bUXMScrTY9h0mguX7t-bMFPpUC9MByfntmH7XBmswuru2Q-badDQ>
Received: from localhost (bzq-109-65-33-130.red.bezeqint.net [109.65.33.130])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3282C80065;
        Thu,  9 May 2019 13:43:40 -0400 (EDT)
Date:   Thu, 9 May 2019 20:43:38 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Message-ID: <20190509174338.GA24432@splinter>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
 <20190509102315.GA31824@splinter>
 <1627338.1fd8ofggM8@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627338.1fd8ofggM8@kreacher>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 09, 2019 at 07:18:28PM +0200, Rafael J. Wysocki wrote:
> So does the patch below fix it for you?

Yes. Thanks for the fix. Feel free to add my tag:

Tested-by: Ido Schimmel <idosch@mellanox.com>
