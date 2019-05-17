Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C2921801
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbfEQMJw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 08:09:52 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:33508 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfEQMJv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 08:09:51 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id AA5C125AD7D;
        Fri, 17 May 2019 22:09:49 +1000 (AEST)
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id B05CF94048B; Fri, 17 May 2019 14:09:47 +0200 (CEST)
Date:   Fri, 17 May 2019 14:09:47 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc:     linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFT v3 0/3] thermal: rcar_gen3_thermal: Update
 calculation formula due to HW evaluation
Message-ID: <20190517120946.2losrmjowl6uuqeq@verge.net.au>
References: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557777835-19454-1-git-send-email-ykaneko0929@gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, May 14, 2019 at 05:03:52AM +0900, Yoshihiro Kaneko wrote:
> This series was inspired by a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.
> 
> This series is based on the master branch of Linus Torvalds's linux tree.

Thanks Kaneko-san,

this looks good to me.

For all patches:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Tested-by: Simon Horman <horms+renesas@verge.net.au>



