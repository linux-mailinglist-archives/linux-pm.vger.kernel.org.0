Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863861CFC51
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 19:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgELRh2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRh2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 13:37:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD7EC061A0C;
        Tue, 12 May 2020 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DCkW+DNwr19hHmbXKVQoMr/Q7HG5L/LhiN+F8TjAGHA=; b=g/lee58WDHlh6RZ1NYB30oncDC
        h8/N48R0jv5QVh1AS1ck3dp87ajwfNSb2XFkFlzwOm6Lrvz4DbEKzrX4TbjTPLrlwAfhAPYo50AbY
        NLuC918tr0E19pPKzhhk7CL/2KwjaHRNijuFi7TGPH/HLrQLeaUPp+xCkwVJX9tGRRD0nfPmzRucu
        GTAZQYPgl44qeE3pU0/C7s5eNBrypBMduYCU8c5sH1DELcS3t/MuUWD/WgP4+gVda1Ap1SLH4ssq7
        pF+Iks4knEALHxb8oiEOmcu3GVTnA0rGAEkz/ivIFa26/hoyDcORcNKs3WQVxDoE3G1EYlYuyvrNA
        baG93URA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYYqL-0007T4-8d; Tue, 12 May 2020 17:37:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44E68300261;
        Tue, 12 May 2020 19:37:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 367782B956661; Tue, 12 May 2020 19:37:22 +0200 (CEST)
Date:   Tue, 12 May 2020 19:37:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, dsmythies@telus.net,
        daniel.lezcano@linaro.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.sampat@in.ibm.com,
        pratik.r.sampat@gmail.com
Subject: Re: [RFC 1/1] Weighted approach to gather and use history in TEO
 governor
Message-ID: <20200512173722.GM2978@hirez.programming.kicks-ass.net>
References: <20200511141055.43029-1-psampat@linux.ibm.com>
 <20200511141055.43029-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511141055.43029-2-psampat@linux.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Just a quick note..

On Mon, May 11, 2020 at 07:40:55PM +0530, Pratik Rajesh Sampat wrote:

> +	/*
> +	 * Rearrange the weight distribution of the state, increase the weight
> +	 * by the LEARNING RATE % for the idle state that was supposed to be
> +	 * chosen and reduce by the same amount for rest of the states
> +	 *
> +	 * If the weights are greater than (100 - LEARNING_RATE) % or lesser
> +	 * than LEARNING_RATE %, do not increase or decrease the confidence
> +	 * respectively
> +	 */
> +	for (i = 0; i < drv->state_count; i++) {
> +		unsigned int delta;
> +
> +		if (idx == -1)
> +			break;
> +		if (i ==  idx) {
> +			delta = (LEARNING_RATE * cpu_data->state_mat[last_idx][i]) / 100;

100 is a crap number to divide by as a computer. We bio-puddings happend
to have 10 digits, so 100 makes sense to us, but it does not to our
binary friends.


