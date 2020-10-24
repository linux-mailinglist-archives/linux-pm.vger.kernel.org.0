Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04857297B78
	for <lists+linux-pm@lfdr.de>; Sat, 24 Oct 2020 10:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760062AbgJXI0i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Oct 2020 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760061AbgJXI0g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Oct 2020 04:26:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1FC0613CE;
        Sat, 24 Oct 2020 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7WW5OjIy5DyHhu4sd+/BFehn7zhBtJPdgdSvBW+0nug=; b=od7s9IcHsTFcQ60ryu18jthu4I
        tb2R2rJxn3zQfbHPnVVKSnxt2ZAPoC2wcS8OcyYayPjWJ6Wmgb37qXN8hvJ1rOoUPe3XJMzJpg5s+
        kwmAWmOfSggXZaqgigIHK2sVs9ZoKzHvSUaPhBDeH1nzRObTzMEGFhxhZJJ030Q5RBau+Y9QPerqq
        DQs31HF9msjTKWVMYSQzeOoAnTNru1QN+nA9aIs3LEgFBn/fkMNw87uNWF7cBD66lsU8Vjiee3H8Q
        EYuvrzHBEfGoPK2QCqcnsfAO67lXimVaecmmG4sZTjnBESEZYL6SRLDl7I5dlLXA8F1pxnVc3s+9J
        u21gzJUg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWEsU-00037d-Od; Sat, 24 Oct 2020 08:26:18 +0000
Date:   Sat, 24 Oct 2020 09:26:18 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Claude Yen <claude.yen@mediatek.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        wsd_upstream@mediatek.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PM / s2idle: Export s2idle_set_ops
Message-ID: <20201024082618.GA10844@infradead.org>
References: <20201022061748.13730-1-claude.yen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022061748.13730-1-claude.yen@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 22, 2020 at 02:17:47PM +0800, Claude Yen wrote:
> This series based on 5.9-rc1
> 
> As suspend_set_ops is exported in commit a5e4fd8783a2
> ("PM / Suspend: Export suspend_set_ops, suspend_valid_only_mem"),
> exporting s2idle_set_ops to make kernel module setup s2idle ops too.
> 
> In this way, kernel module can hook platform suspend functions
> regardless of Suspend-to-Ram(S2R) or Suspend-to-Idle(S2I)

Where is the actual users of the export?
