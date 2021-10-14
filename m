Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE7842D615
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 11:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbhJNJdb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Oct 2021 05:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhJNJdb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 14 Oct 2021 05:33:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CD8D610F9;
        Thu, 14 Oct 2021 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634203887;
        bh=8bLxjH519a9u+yaeJrlmj0VDcOyXJXQtkx86R85XdUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unXPh2p9skXe4U7/udFxYXeDo0IwsnS8P84X75YQ5T26BOhfOKyGTuds9z8I/2Y+T
         HW6INuvv6aLtWnyXz0IuQxykAMqyQJ6TVoyqLX888ZotDRvjN0U1JtnBmSCKlpMu83
         pokXvVuHyT84eEsbW7217wBI8RVO5N7qFz4CXhPED2btIzIuB4ZRBqP3/NKyuOq7wC
         yG78UkwanbCrlt/N8+Yr/ETgAofX3HUxTed9Y8+k6oCF73FUrV1ocWxhSlDm4IJ8s4
         bqA+gyYG902TTmJdDWH+zfWkGqIBUHixdiNQV7ATQtSFf9nV/OEdsJZrEmMW2vz3Fd
         qycfwiHU86eig==
Date:   Thu, 14 Oct 2021 10:31:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] ptrace: Order and comment PT_flags
Message-ID: <20211014093121.GA8239@willie-the-truck>
References: <20211009100754.690769957@infradead.org>
 <20211009101444.971532166@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009101444.971532166@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Oct 09, 2021 at 12:07:57PM +0200, Peter Zijlstra wrote:
> Add a comment to the PT_flags to indicate their actual value, this
> makes it easier to see what bits are used and where there might be a
> possible hole to use.
> 
> Notable PT_SEIZED was placed wrong, also PT_EVENT_FLAG() space seems
> ill defined, as written is seems to be meant to cover the entire
> PTRACE_O_ range offset by 3 bits, which would then be 3+[0..21],
> however PT_SEIZED is in the middle of that.

Why do you think PT_EVENT_FLAG() should cover all the PTRACE_O_* options?
Just going by the name and current callers, I'd only expect it to cover
the PTRACE_EVENT_* flags, no?

But in any case, having the comments is helpful, so:

Acked-by: Will Deacon <will@kernel.org>

Will
