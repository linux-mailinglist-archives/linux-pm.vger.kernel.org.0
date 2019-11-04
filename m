Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30AE7EE3E8
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2019 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfKDPem (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Nov 2019 10:34:42 -0500
Received: from verein.lst.de ([213.95.11.211]:39625 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfKDPem (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Nov 2019 10:34:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 194CC68BE1; Mon,  4 Nov 2019 16:34:39 +0100 (CET)
Date:   Mon, 4 Nov 2019 16:34:38 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Keith Busch <kbusch@kernel.org>, Chris Healy <cphealy@gmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4] nvme: Add hardware monitoring support
Message-ID: <20191104153438.GA17328@lst.de>
References: <20191102145530.16104-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102145530.16104-1-linux@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
