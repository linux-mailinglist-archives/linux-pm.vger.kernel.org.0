Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 071DA1AC9E
	for <lists+linux-pm@lfdr.de>; Sun, 12 May 2019 16:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfELObC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 10:31:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33409 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfELObC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 10:31:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so5105359plp.0;
        Sun, 12 May 2019 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8MmPir51Pep1QquiMlNrOGRX1Y2TZtpKY9viaAkjkQI=;
        b=rhWhYEal8pAMHfedEvpe/VBQbVlKLqFtXxiQi/XHXYuwxAEt9D0juekW4ZFobDtJXQ
         44oh2TGhUvx6yE/t+ilpT/WGKb0/DTK+h2WOhXvxp8TTaIkkeW+cKK4y7p+dSW7tmY5o
         ktiEfu0TC5Ll2KqXN1KEHgdtYaIzNAohjSs5RsxOiKeOjZjnust9Vn9J3p1V2q5GVsvD
         vJM2pOAkNyUS7obCx76y1hN6YownFya1JANnazvaCz/y3t2hlyUv3z8uSoCOxwFr1Inr
         f3Ef8OXBgVB+ArWaaaLwqXAjynxcN7FgSAr9r8xloN1WhGyu/+2QxvCUMkRMghxMcpoY
         kuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MmPir51Pep1QquiMlNrOGRX1Y2TZtpKY9viaAkjkQI=;
        b=GFlx3vGsWuytvd7/rw05rhhrYXzmRFn669qUi56o2/ZRP3XhH9SBTiOTfQrQmuIdzA
         aWq/omnV31/pM5rEo950F8mkmcFjPxC4n2gEmVF3SIckpe4q2qHzEazUs9lRhgKK8Yfo
         E2Vv2++F/58CswYIlIRGEgpWhHPcxgmrV0eJXnGRj5xZ4tS1HA9IkkWuukaseINxiLGd
         U+/5v/ZlFyru4+Xo68ChdNUETw28+MlVEiEtRMlwMWeGAXO1KGb6VIsWC9PQard0OXX4
         NkrYLfxjDUInzT5X4cYFRcKBPo6ymtOxBsErL9/gRiUdEnb06HHLlxLY/EJNb29lmjsd
         sJ0Q==
X-Gm-Message-State: APjAAAU/uiXkwXLa9nntENCncNRerlLOAT83FrttqIrsn3mpD3UHbeBg
        5dbfDP36S467I6BhCZW+Xx4=
X-Google-Smtp-Source: APXvYqyHv4eu6dOl7ANFLZc88b1efraMSjQavaCvSp5oLIBuxCMPX9SS9p4rYP6iiwoMUxxTzZ0OmQ==
X-Received: by 2002:a17:902:7594:: with SMTP id j20mr25677961pll.78.1557671461643;
        Sun, 12 May 2019 07:31:01 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id z187sm15546976pfb.132.2019.05.12.07.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 07:31:00 -0700 (PDT)
Date:   Sun, 12 May 2019 23:30:58 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        "hange-folder>?" <toggle-mailboxes@minwooim-desktop>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190512143056.GA7761@minwooim-desktop>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (ed9d7727) (2018-07-16)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

> > +	union nvme_result res;
> > +	int ret;
> > +
> > +	if (!result)
> > +		return -EINVAL;
> > +
> > +	memset(&c, 0, sizeof(c));
> > +	c.features.opcode = nvme_admin_get_features;
> > +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
> > +
> > +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> > +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> > +	if (ret >= 0)
> > +		*result = le32_to_cpu(res.u32);
> May be add a check for result here in above if before deref pointer :-
> 	if (ret >= 0 && result)
> 

'result' already has been checked in a few lines above.
