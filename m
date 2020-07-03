Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471042130C2
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jul 2020 03:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgGCBA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jul 2020 21:00:26 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40199 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgGCBAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2020 21:00:25 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8BD135C0194;
        Thu,  2 Jul 2020 21:00:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Jul 2020 21:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=mq9RgoRCE9wTH
        brhBmftiU2UbhFxdZX3j8GQgZzYBpQ=; b=kx3IekKb88Ei2lpN8Iq9x+jond/Gn
        1tcRJTyDPkFGJAxuWJCJTjO2kS/O42BEvrCiTBNUqsAYMEA5itwfnUZl3goWQL5t
        Fi87OUuM+wXlACurK50AUf6I7n/oIAJq8Dd8jyh/QSoXYnFJCmzEhDRLZulrS5/j
        gU8PD7YGU82PUo/mEPi0SCIYYVF+X83v0FHfesZinB1wOuRTBvqpVeJ4pJ7WGrYn
        o7bdE7HQI2OdcZwLbPWGPkGbHOOXJsSn6dAwzc10o34hWHjjEG86F0G6qyRQk+le
        i3FuHwi0qirO1k0vg1kDHKkaBda5DBuveM89Xvs6ouVXf1aG8ZtTjCdzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=mq9RgoRCE9wTHbrhBmftiU2UbhFxdZX3j8GQgZzYBpQ=; b=BU5zMkut
        7SS7BDm0SFqhj7tGVLSaTZLkTbZNV2r2U73NOxeOnBANQcMcHsjNHvqYcZx9qT+M
        hik5I3ZyLvyg1xMDF0FUqtcMf+XjfomPVR7zjgEJ+9GgvNj8+qHvlY157WMgBbqz
        zdgOhArat44+kZABgjX4AzaNgnWZ7biZu1dBuKZ2i4U3E7/HXWb6OvXNaFL/1vlm
        Icsphs2ZIh5fiTw5WTJfZbfgORoJSc0qUf/gS6vsdIQR9QqOWIkI72JsWzAPoXhX
        EwgyUELQbqkCQ4qWS3pSCuxQ05QhTzHXrJHCL28EhJ/l4DGpspw5QcP1EmSkLnUu
        J6pPBPpGj5OvFw==
X-ME-Sender: <xms:KIP-XqZWyorwo4VI90KX4YNGQWlptatzkrJEMMrkfMZbnwym4r8oPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdehgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhnhicu
    nfhinhcuoegurghnnhihsehkughrrghgtdhnrdguvghvqeenucggtffrrghtthgvrhhnpe
    etgffhheetueeggfeuveeiuddtudehteehgefhveejleevhffgteeludehudeuudenucfk
    phepjeefrddvvdehrdegrddufeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepuggrnhhnhieskhgurhgrghdtnhdruggvvh
X-ME-Proxy: <xmx:KIP-XtYk_v6rj47vBfjd4QrlEUSyu9NmVt7uP5TLLlErBOSVQ5t2-A>
    <xmx:KIP-Xk9L9mdCPAncCU6efz-Eh6MEFzQ9_WmJ2qje9boBfGfjGpwxJg>
    <xmx:KIP-Xsp2Pr99dZdXbLwgnrY480VICvwAQ7uGFEX1jhBQJ9hkr3dyMQ>
    <xmx:KIP-XsV4xyEUBULrTRpp_hfV-Bq_1Ckrc4xHdq9xdkyN2oPjTHU8Iw>
Received: from pinwheel.hsd1.wa.comcast.net (c-73-225-4-138.hsd1.wa.comcast.net [73.225.4.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 091863280059;
        Thu,  2 Jul 2020 21:00:22 -0400 (EDT)
From:   Danny Lin <danny@kdrag0n.dev>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danny Lin <danny@kdrag0n.dev>
Subject: Re: [PATCH] cpufreq: Record stats when fast switching is enabled
Date:   Thu,  2 Jul 2020 18:00:09 -0700
Message-Id: <20200703010009.220363-1-danny@kdrag0n.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <3268787.3OZuCagV1k@aspire.rjw.lan>
References: <3268787.3OZuCagV1k@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jan 31, 2019 at 2:14 AM, Rafael J. Wysocki wrote:
> On Thu, Jan 31, 2019 at 11:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 31-01-19, 11:03, Rafael J. Wysocki wrote:
> > > On Thu, Jan 31, 2019 at 9:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >
> > > > The only problem that I can think of (or recall) is that this routine
> > > > also gets called when time_in_state sysfs file is read and that can
> > > > end up taking lock which the scheduler's hotpath will wait for.
> > >
> > > What about the extra locking overhead in the scheduler context?
> >
> > What about using READ_ONCE/WRITE_ONCE here ? Not sure if we really
> > need locking in this particular case.
> 
> If that works, then fine, but ISTR some synchronization issues related to that.

Maybe using READ/WRITE_ONCE for time_in_state is problematic, but is
there any reason why atomics wouldn't work for this? As far as I can
tell, atomics are necessary to protect time_in_state due to its
multi-step add operation, and READ/WRITE_ONCE can be used for last_time
because all operations on it are single-op sets/gets.

I've been using the setup described above on a downstream arm64 4.14
kernel for nearly a year with no issues. I haven't noticed any
significant anomalies in the stats so far. The system in question has 8
CPUs split into 3 cpufreq policies and fast switch is used with the
schedutil governor, so it should be exercising the stats update path
enough.

Sorry for bumping an old thread.

