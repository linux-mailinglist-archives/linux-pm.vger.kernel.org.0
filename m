Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FEC30B3AE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 00:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhBAXsQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Feb 2021 18:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBAXsP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2021 18:48:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95CC061573;
        Mon,  1 Feb 2021 15:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+1XaJEm6YZf4J98TFgCBRgeI5HE8lVr+vSWBp40FDII=; b=T/w946GfM85U36YVPAlLIP9ZvB
        98gg8mKhlYyElrWA8qWzTy1dGaSDcq2RJlqAlyEh6GfNAFNKATYuNmPj3ke4u5YtcYc8ZF0gPF7GQ
        h4IfO70IkhXgoi0LUsZx1vplb/xwlczkNmwf1PulyqduUQNPSPSbMoxJn/A5k3b7pFZxQCRkTyvSy
        Rdc4ntnW2ylEOOTtiAlXBAF09/dTTsTmxBx9Jo9R46Yp5zyLLaxWUwdgrwFuaO9dPml3Eiv8bPdi5
        rW5MYlQeFOMmyLWGlxYybY7zo9/sp+p/9ek9og84LxYsKVrBf1fSBz1qySoTPOD3MgqJNhJRGCwJb
        wTxs1Kzw==;
Received: from [2601:1c0:6280:3f0::2a53]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l6iuq-00038y-Nm; Mon, 01 Feb 2021 23:47:33 +0000
To:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: do not suspend/sleep
Message-ID: <f4cfa048-f612-8e38-2899-988471d84faa@infradead.org>
Date:   Mon, 1 Feb 2021 15:47:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all.

I usually run my systems (laptops) so that they will suspend to RAM
after 30 or 60 minutes of no use (no input), but when I am building
e.g. 3 kernels, that will take more than 30 minutes and I don't want
the system to suspend during that time.

I was wondering what options are available to prevent entering suspend.
I am willing to manually enter a command to make that happen if one
is available.

I was considering a way to generate a fake kbd or mouse input every
M (e.g. 29) minutes.
If that is feasible, what would someone suggest to use here?
(I can script the "wait M minutes" part :) Just need the "how to
inject a keystroke or mouse input" part.)

My first idea was some way to prevent suspend/sleep if the system load
level is > N (e.g. 4 -- user input), but I don't know where to do that.

thanks for any suggestions.

-- 
~Randy

