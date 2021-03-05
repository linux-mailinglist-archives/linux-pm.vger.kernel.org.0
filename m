Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4E32E35A
	for <lists+linux-pm@lfdr.de>; Fri,  5 Mar 2021 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEIHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Mar 2021 03:07:50 -0500
Received: from verein.lst.de ([213.95.11.211]:45152 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhCEIHu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Mar 2021 03:07:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7220868BEB; Fri,  5 Mar 2021 09:07:48 +0100 (CET)
Date:   Fri, 5 Mar 2021 09:07:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org
Subject: driver notification when switching between battery vs AC power?
Message-ID: <20210305080748.GA17954@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

do we have infrastructure that notifies the driver when a system is
switching from batter to AC power?  There is a proposal to make the
Linux NVMe driver power management match the policy used by the
Windows driver more closely, which does this and we'd like to prototype
that to check what difference the policy makes.
