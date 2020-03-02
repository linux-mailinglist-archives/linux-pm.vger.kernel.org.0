Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0951765CB
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2020 22:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBVTR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Mar 2020 16:19:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:59040 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBVTR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Mar 2020 16:19:17 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1B823823;
        Mon,  2 Mar 2020 21:19:17 +0000 (UTC)
Date:   Mon, 2 Mar 2020 14:19:16 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
Message-ID: <20200302141916.1c6d8abe@lwn.net>
In-Reply-To: <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
        <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 17 Feb 2020 17:20:32 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> most of the stuff there can be re-used with ReST format,
> but we need to add an empty TOC and remove the existing
> entries, as the following conversion patches will be re-adding
> them, as they're converted.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Rafael, do you want to carry the cpu-freq changes from this set, or should
I just apply the whole thing over here?

Thanks,

jon
