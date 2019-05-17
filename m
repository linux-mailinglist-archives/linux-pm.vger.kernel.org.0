Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D121ABE
	for <lists+linux-pm@lfdr.de>; Fri, 17 May 2019 17:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfEQPgd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 17 May 2019 11:36:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40001 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbfEQPgc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 17 May 2019 11:36:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so3513675plb.7
        for <linux-pm@vger.kernel.org>; Fri, 17 May 2019 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=46oHXKvqSKWOuSCep8CgcAD851AYqrmGpjUGnxm4x+Q=;
        b=L9MqeWCSAyXVGeJCFI/FaJ3sCxf/aJ5yg2oT3O6lhu/oOBqXXWD3ZFQNTak6miv1Ql
         8mlbx7Ha0iF5Qqd9GY/JUMQLKHiVuV/dJW6qARLP6zqNPYBMzV5jax5GwOsDdOafVzBf
         CypQyGcXFiY11xx4tEEfCCNdyFtl56FE48Gb1gLAjS8Xt+OD3peA41KSk8n65cxl2IRo
         VB8vCZ6Q0X5lYvxWC+4aCAQCfkivbHzCWJ7xj2lnYMkP7ykZbAdkz6U8RqCycghQ7fwH
         hS5pH/laHP4Lz6bOdbZOBrDvjSmMuf6RBn9WdoXo8Y8OQ7kk8QWUWsA3UZfW7Wf5bYJ4
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=46oHXKvqSKWOuSCep8CgcAD851AYqrmGpjUGnxm4x+Q=;
        b=sQy4/KtI2JWNDcppsULGlO7Z2AqWMDRDPtChUG66SawCoibtaVUc7Biw7Fss1LUi6f
         U9C0xu8vOPtNjCcBQSWePCMgwI7OR3l3jiEvcRVEFxW5wlf9znc7xf8ODScFD9IWN2Xs
         QqrIYSwN2LLHKJwogRImTPM/xOJoY/f0XGMHQJ+O/8TIHqbWTKoEe3jgnMhsmKUMs0y/
         E5PXKH5pew/PqdQYrejj9SZkZdVl2vuXNwmTNkgnFKHuSSQc9peseSY6RqiUgOD+Go2M
         f3/p7Ii3zQvpqsWGbQXdABdlzeD17QpIGSHoJ2ZkxvAHuPEttb7laq9X91EpqrPHUENi
         9MPQ==
X-Gm-Message-State: APjAAAU6u+7P4e1EzBRp6mYqvprwz+1fOm+bhvGyXCPD4T9FtTy619K0
        P9b15uI+GwNiDNmm/DAURtRmZDIOoQFVgxLBP/MhvQ==
X-Google-Smtp-Source: APXvYqxzP0QWgEuoEYzgQJxETVLl03tm1qImUSkV4WabYS1+qZ+EYdKcv8RUBdDHD5xoUJkkk+GfiSfuppl6Sd56ulQ=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr18854602plf.20.1558107392336;
 Fri, 17 May 2019 08:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com> <2bf1e2cf-b922-d947-c939-375aba75994d@intel.com>
 <CAC5umygRTpq3GktaMKBdC8+-ghkJKCzFME+rm+V6vasrOAyOPw@mail.gmail.com> <20190517150924.GA25006@localhost.localdomain>
In-Reply-To: <20190517150924.GA25006@localhost.localdomain>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sat, 18 May 2019 00:36:21 +0900
Message-ID: <CAC5umyhu6_s_CTvOL4_Rp7unqcw+jt9fPo++iGnumqDFQJecxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: add thermal zone infrastructure
To:     Keith Busch <kbusch@kernel.org>
Cc:     "Heitke, Kenneth" <kenneth.heitke@intel.com>,
        linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

2019=E5=B9=B45=E6=9C=8818=E6=97=A5(=E5=9C=9F) 0:14 Keith Busch <kbusch@kern=
el.org>:
>
> On Sat, May 18, 2019 at 12:01:57AM +0900, Akinobu Mita wrote:
> >
> > This is work_struct, not workqueue.  So it can't be destroyed.
> > But I noticed that we should call flush_work for thermal_work at
> > unregistering thermal zone devices.
>
> Instead of creating yet-another-work_struct, let's append this event's
> action to the existing async_event_work.

Good idea.
