Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED7177823
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 15:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgCCOBW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 09:01:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgCCOBW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Mar 2020 09:01:22 -0500
Received: from onda.lan (ip-109-40-2-133.web.vodafone.de [109.40.2.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 794622073D;
        Tue,  3 Mar 2020 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583244081;
        bh=0jraC2vhT4/0rCJ9zdkEYr2ZoyzfD3nPO9KuM2YUf3U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XgfTOSViQ9Dh9lgvV1BhgLpP8NJah/z85viZZHlXUf/oovxZQr58rP5bTp30QXDyw
         8O3NSztDDdNgMWoAPaSxixUNSeLeuxGtc68g9SMeZGtmAOlNw3STJwgu1yrgrhVy+h
         a2NMk/OlPNXxA+YAwk2ab21yIZhdG4qllZ20QQGg=
Date:   Tue, 3 Mar 2020 15:01:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
Message-ID: <20200303150117.7094df6e@onda.lan>
In-Reply-To: <20200302141916.1c6d8abe@lwn.net>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
        <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
        <20200302141916.1c6d8abe@lwn.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Em Mon, 2 Mar 2020 14:19:16 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon, 17 Feb 2020 17:20:32 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > most of the stuff there can be re-used with ReST format,
> > but we need to add an empty TOC and remove the existing
> > entries, as the following conversion patches will be re-adding
> > them, as they're converted.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Rafael, do you want to carry the cpu-freq changes from this set, or should
> I just apply the whole thing over here?

Hi Jon,

As Rafael should be applying the cpu-freq via his tree, I'm re-sending the
remaining patches on this series as:

	[PATCH v3 00/18] Manually convert  thermal, crypto and misc devices to ReST

Regards,
Mauro
