Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155B62817C7
	for <lists+linux-pm@lfdr.de>; Fri,  2 Oct 2020 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgJBQXN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Oct 2020 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQXM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2020 12:23:12 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55454C0613D0;
        Fri,  2 Oct 2020 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z4MGYJtuhPd38PKWjqnG9wYyjqiUQeeeO69PRxHNyoE=; b=GPeQ9mHO7kiEN8voDAzztyd60g
        JwT/Y6l0mSaLVTYSkILFcPYMROO5417qY8Z4kr5kWqKQagdM59Fux/Aanx43I/hf7eWEmJ1o9mLcM
        dABKEpU8k5YrRUF6w/54d5l9ci7BosaU7VJXNglQnFD6nNAKs8+66FKUsTyrr5/glCyo=;
Received: from p200300ccff0a30001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:3000:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kONpo-0004HK-SZ; Fri, 02 Oct 2020 18:23:05 +0200
Date:   Fri, 2 Oct 2020 18:23:03 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1] power: supply: document current direction
Message-ID: <20201002182303.51db1289@aktux>
In-Reply-To: <20200827140248.37749-1-sebastian.reichel@collabora.com>
References: <20200827140248.37749-1-sebastian.reichel@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 27 Aug 2020 16:02:48 +0200
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> Currently the sign for CURRENT_NOW and CURRENT_AVG is a bit
> of a mess. There are basically 3 different ways battery fuel
> gauges report the current:
> 
> 1. uses negative values for discharging and positive values
>    for charging
> 2. uses positive values for discharging and negative values
>    for discharging (opposit of 1)
> 3. only uses positive values
> 
> As a result userspace currently cannot use the sign at all in
> a generic way. Let's solve the issue by documenting a canonical
> way for reporting the data and ensure new drivers follow this
> way. Then existing drivers can be fixed on a case-by-case basis.
> 
> The 'negative value = battery discharging' has been choosen,
> since there are only very few drivers doing it the other way
> around.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

would be nice if this comes in, so that is it clearly specified.

Regards,
Andreas
