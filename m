Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4AC217C
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfI3NJl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 09:09:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:48828 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730637AbfI3NJl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 09:09:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7732555A;
        Mon, 30 Sep 2019 13:09:40 +0000 (UTC)
Date:   Mon, 30 Sep 2019 07:09:39 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal management updates for v5.4-rc1
Message-ID: <20190930070939.706c9dfa@lwn.net>
In-Reply-To: <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
References: <a9e8e68f34139d5a9abb7f8b7d3fe64ff82c6d96.camel@intel.com>
        <CAHk-=whua2XSTLd3gtqVHfq5HtGnjhRUv7vA6SUfkbVUebqWJQ@mail.gmail.com>
        <64d13484950cab570e5f2691d7cdeca292882d95.camel@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 27 Sep 2019 15:29:47 -0400
Doug Ledford <dledford@redhat.com> wrote:

> If you are doing linux kernel development, and you are doing a rebase,
> please read Documentation/When_Not_To_Rebase.rst before rebasing your
> code and sending it to Linus.  You've been warned.

For anybody following along at home, the proper spelling for that is
Documentation/maintainer/rebasing-and-merging.txt or
https://www.kernel.org/doc/html/latest/maintainer/rebasing-and-merging.html

jon
