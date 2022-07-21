Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0A57D6FD
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jul 2022 00:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiGUWfg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Jul 2022 18:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiGUWfO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2022 18:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 534C125E1
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 15:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658442908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3sdCgNwyGzNe6Cz4z9RbORPZPqKisFUaqCsD1RI8+g=;
        b=EvTQLAR2t94WlQlVsxVtZlyvS+g8TcjUsHtJ6g0X94b3bCaa3HY1EwtVcJicPbyRSCnwcT
        EHlz3YnVELceUePAzO6fRR1uirgCpDn/CaoF9yI17okNE3Os242smGGNJQarnC+NpyIkO6
        MfPUSsbPZPcqhxNb4u+8qpHLsUhKkPE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-wAgCaSP9MIiO4emJcZWuNw-1; Thu, 21 Jul 2022 18:34:58 -0400
X-MC-Unique: wAgCaSP9MIiO4emJcZWuNw-1
Received: by mail-il1-f197.google.com with SMTP id h28-20020a056e021d9c00b002dc15a95f9cso1614191ila.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2022 15:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=r3sdCgNwyGzNe6Cz4z9RbORPZPqKisFUaqCsD1RI8+g=;
        b=R8HyQICNR6+rOAaW6Jm4O121xSolhQ/KcuUWLs3Pf/P+9opd7Z96uI4Ap/Zjo6vcbS
         Z9r0r83WFB2gqrs0X7yLrLMhxaQw7tvQYnBnAq/a9WmEmcO28bntUuFNJVkUNoZjtTp3
         isPpdsEuVGguKpAtp2XKYReOXrcNqypogTRtKHlP7sAIsnBR2nCQYFR2FVRQeFQRNifc
         7G9GB3kNtq6boGaV1J8ryiYleUUMiEjU7PAN6Jh9PYsVkkZm7sH88+NL4RzoVMOtQbiT
         TTjKNA8K8SlUgO9r+JT70mlUnyZH3ZfiunFVxm5laWqybbLQOHQWrmmxomZaiDjDwhER
         2a/Q==
X-Gm-Message-State: AJIora+6kgIc8U6qEIow6GePQEIRGatkKRGb9en/e5BruYGhqgsKltmY
        HeE8jg+8Tfd4cVpt8Fu/Ic3hK5o23f6VxnOVsfkCmIJgOXXnuL0PvYF68oEVmichBz9PLw2kGLW
        dkL6kaRK0qfEB+kqxRsk=
X-Received: by 2002:a05:6602:330e:b0:67b:9fed:49db with SMTP id b14-20020a056602330e00b0067b9fed49dbmr254258ioz.54.1658442897304;
        Thu, 21 Jul 2022 15:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1upfOvx2IuMXWj8108fxKfQwX1gQNZ4j2bBsTtZQUyd0UR+JuSP7WK9WLRRPvOKTUpzQq6/Ug==
X-Received: by 2002:a05:6602:330e:b0:67b:9fed:49db with SMTP id b14-20020a056602330e00b0067b9fed49dbmr254252ioz.54.1658442896965;
        Thu, 21 Jul 2022 15:34:56 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t2-20020a056602140200b0066952cfe3e2sm1334400iov.39.2022.07.21.15.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:34:56 -0700 (PDT)
Date:   Thu, 21 Jul 2022 16:34:55 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] vfio/pci: Implement
 VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY/EXIT
Message-ID: <20220721163455.5ba133ef.alex.williamson@redhat.com>
In-Reply-To: <20220719121523.21396-5-abhsahu@nvidia.com>
References: <20220719121523.21396-1-abhsahu@nvidia.com>
        <20220719121523.21396-5-abhsahu@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Jul 2022 17:45:22 +0530
Abhishek Sahu <abhsahu@nvidia.com> wrote:

> Currently, if the runtime power management is enabled for vfio-pci
> based devices in the guest OS, then the guest OS will do the register
> write for PCI_PM_CTRL register. This write request will be handled in
> vfio_pm_config_write() where it will do the actual register write of
> PCI_PM_CTRL register. With this, the maximum D3hot state can be
> achieved for low power. If we can use the runtime PM framework, then
> we can achieve the D3cold state (on the supported systems) which will
> help in saving maximum power.
> 
> 1. D3cold state can't be achieved by writing PCI standard
>    PM config registers. This patch implements the following
>    newly added low power related device features:
>     - VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY
>     - VFIO_DEVICE_FEATURE_LOW_POWER_EXIT
> 
>    The VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY will move the device into
>    the low power state, and the VFIO_DEVICE_FEATURE_LOW_POWER_EXIT
>    will move the device out of the low power state.

Isn't this really:

	The VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY feature will allow the
	device to make use of low power platform states on the host
	while the VFIO_DEVICE_FEATURE_LOW_POWER_EXIT will prevent
	further use of those power states.

ie. we can't make the device move to low power and every ioctl/access
will make it exit, it's more about allowing/preventing use of those
platform provided low power states.

> 
> 2. The vfio-pci driver uses runtime PM framework for low power entry and
>    exit. On the platforms where D3cold state is supported, the runtime
>    PM framework will put the device into D3cold otherwise, D3hot or some
>    other power state will be used. If the user has explicitly disabled
>    runtime PM for the device, then the device will be in the power state
>    configured by the guest OS through PCI_PM_CTRL.

This is talking about disabling runtime PM support for a device on the
host precluding this interface from allowing the device to enter
platform defined low power states, right?
 
> 3. The hypervisors can implement virtual ACPI methods. For example,
>    in guest linux OS if PCI device ACPI node has _PR3 and _PR0 power
>    resources with _ON/_OFF method, then guest linux OS invokes
>    the _OFF method during D3cold transition and then _ON during D0
>    transition. The hypervisor can tap these virtual ACPI calls and then
>    call the low power device feature IOCTL.
> 
> 4. The 'pm_runtime_engaged' flag tracks the entry and exit to
>    runtime PM. This flag is protected with 'memory_lock' semaphore.
> 
> 5. All the config and other region access are wrapped under
>    pm_runtime_resume_and_get() and pm_runtime_put(). So, if any
>    device access happens while the device is in the runtime suspended
>    state, then the device will be resumed first before access. Once the
>    access has been finished, then the device will again go into the
>    runtime suspended state.
> 
> 6. The memory region access through mmap will not be allowed in the low
>    power state. Since __vfio_pci_memory_enabled() is a common function,
>    so check for 'pm_runtime_engaged' has been added explicitly in
>    vfio_pci_mmap_fault() to block only mmap'ed access.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 151 +++++++++++++++++++++++++++++--
>  include/linux/vfio_pci_core.h    |   1 +
>  2 files changed, 144 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 9517645acfa6..726a6f282496 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -259,11 +259,98 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
>  	return ret;
>  }
>  
> +static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev)
> +{
> +	/*
> +	 * The vdev power related flags are protected with 'memory_lock'
> +	 * semaphore.
> +	 */
> +	vfio_pci_zap_and_down_write_memory_lock(vdev);
> +	if (vdev->pm_runtime_engaged) {
> +		up_write(&vdev->memory_lock);
> +		return -EINVAL;
> +	}

Awkward that we zap memory for the error path here, but optimizing
performance for a user that can't remember they've already activated
low power for a device doesn't seem like a priority ;)

> +
> +	vdev->pm_runtime_engaged = true;
> +	pm_runtime_put_noidle(&vdev->pdev->dev);
> +	up_write(&vdev->memory_lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_pci_core_pm_entry(struct vfio_device *device, u32 flags,
> +				  void __user *arg, size_t argsz)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> +	if (ret != 1)
> +		return ret;
> +
> +	/*
> +	 * Inside vfio_pci_runtime_pm_entry(), only the runtime PM usage count
> +	 * will be decremented. The pm_runtime_put() will be invoked again
> +	 * while returning from the ioctl and then the device can go into
> +	 * runtime suspended state.
> +	 */
> +	return vfio_pci_runtime_pm_entry(vdev);
> +}
> +
> +static void vfio_pci_runtime_pm_exit(struct vfio_pci_core_device *vdev)
> +{
> +	/*
> +	 * The vdev power related flags are protected with 'memory_lock'
> +	 * semaphore.
> +	 */
> +	down_write(&vdev->memory_lock);
> +	if (vdev->pm_runtime_engaged) {
> +		vdev->pm_runtime_engaged = false;
> +		pm_runtime_get_noresume(&vdev->pdev->dev);
> +	}
> +
> +	up_write(&vdev->memory_lock);
> +}
> +
> +static int vfio_pci_core_pm_exit(struct vfio_device *device, u32 flags,
> +				 void __user *arg, size_t argsz)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	int ret;
> +
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET, 0);
> +	if (ret != 1)
> +		return ret;
> +
> +	/*
> +	 * The device should already be resumed by the vfio core layer.
> +	 * vfio_pci_runtime_pm_exit() will internally increment the usage
> +	 * count corresponding to pm_runtime_put() called during low power
> +	 * feature entry.
> +	 */
> +	vfio_pci_runtime_pm_exit(vdev);
> +	return 0;
> +}
> +
>  #ifdef CONFIG_PM
>  static int vfio_pci_core_runtime_suspend(struct device *dev)
>  {
>  	struct vfio_pci_core_device *vdev = dev_get_drvdata(dev);
>  
> +	down_write(&vdev->memory_lock);
> +	/*
> +	 * The user can move the device into D3hot state before invoking
> +	 * power management IOCTL. Move the device into D0 state here and then
> +	 * the pci-driver core runtime PM suspend function will move the device
> +	 * into the low power state. Also, for the devices which have
> +	 * NoSoftRst-, it will help in restoring the original state
> +	 * (saved locally in 'vdev->pm_save').
> +	 */
> +	vfio_pci_set_power_state(vdev, PCI_D0);
> +	up_write(&vdev->memory_lock);
> +
>  	/*
>  	 * If INTx is enabled, then mask INTx before going into the runtime
>  	 * suspended state and unmask the same in the runtime resume.
> @@ -393,6 +480,18 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  
>  	/*
>  	 * This function can be invoked while the power state is non-D0.
> +	 * This non-D0 power state can be with or without runtime PM.
> +	 * vfio_pci_runtime_pm_exit() will internally increment the usage
> +	 * count corresponding to pm_runtime_put() called during low power
> +	 * feature entry and then pm_runtime_resume() will wake up the device,
> +	 * if the device has already gone into the suspended state. Otherwise,
> +	 * the vfio_pci_set_power_state() will change the device power state
> +	 * to D0.
> +	 */
> +	vfio_pci_runtime_pm_exit(vdev);
> +	pm_runtime_resume(&pdev->dev);
> +
> +	/*
>  	 * This function calls __pci_reset_function_locked() which internally
>  	 * can use pci_pm_reset() for the function reset. pci_pm_reset() will
>  	 * fail if the power state is non-D0. Also, for the devices which
> @@ -1224,6 +1323,10 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>  		return vfio_pci_core_feature_token(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY:
> +		return vfio_pci_core_pm_entry(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_LOW_POWER_EXIT:
> +		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -1234,31 +1337,47 @@ static ssize_t vfio_pci_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			   size_t count, loff_t *ppos, bool iswrite)
>  {
>  	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +	int ret;
>  
>  	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
>  		return -EINVAL;
>  
> +	ret = pm_runtime_resume_and_get(&vdev->pdev->dev);
> +	if (ret < 0) {

if (ret) {

Thanks,
Alex

> +		pci_info_ratelimited(vdev->pdev, "runtime resume failed %d\n",
> +				     ret);
> +		return -EIO;
> +	}
> +
>  	switch (index) {
>  	case VFIO_PCI_CONFIG_REGION_INDEX:
> -		return vfio_pci_config_rw(vdev, buf, count, ppos, iswrite);
> +		ret = vfio_pci_config_rw(vdev, buf, count, ppos, iswrite);
> +		break;
>  
>  	case VFIO_PCI_ROM_REGION_INDEX:
>  		if (iswrite)
> -			return -EINVAL;
> -		return vfio_pci_bar_rw(vdev, buf, count, ppos, false);
> +			ret = -EINVAL;
> +		else
> +			ret = vfio_pci_bar_rw(vdev, buf, count, ppos, false);
> +		break;
>  
>  	case VFIO_PCI_BAR0_REGION_INDEX ... VFIO_PCI_BAR5_REGION_INDEX:
> -		return vfio_pci_bar_rw(vdev, buf, count, ppos, iswrite);
> +		ret = vfio_pci_bar_rw(vdev, buf, count, ppos, iswrite);
> +		break;
>  
>  	case VFIO_PCI_VGA_REGION_INDEX:
> -		return vfio_pci_vga_rw(vdev, buf, count, ppos, iswrite);
> +		ret = vfio_pci_vga_rw(vdev, buf, count, ppos, iswrite);
> +		break;
> +
>  	default:
>  		index -= VFIO_PCI_NUM_REGIONS;
> -		return vdev->region[index].ops->rw(vdev, buf,
> +		ret = vdev->region[index].ops->rw(vdev, buf,
>  						   count, ppos, iswrite);
> +		break;
>  	}
>  
> -	return -EINVAL;
> +	pm_runtime_put(&vdev->pdev->dev);
> +	return ret;
>  }
>  
>  ssize_t vfio_pci_core_read(struct vfio_device *core_vdev, char __user *buf,
> @@ -1453,7 +1572,11 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
>  	mutex_lock(&vdev->vma_lock);
>  	down_read(&vdev->memory_lock);
>  
> -	if (!__vfio_pci_memory_enabled(vdev)) {
> +	/*
> +	 * Memory region cannot be accessed if the low power feature is engaged
> +	 * or memory access is disabled.
> +	 */
> +	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev)) {
>  		ret = VM_FAULT_SIGBUS;
>  		goto up_out;
>  	}
> @@ -2164,6 +2287,15 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  		goto err_unlock;
>  	}
>  
> +	/*
> +	 * Some of the devices in the dev_set can be in the runtime suspended
> +	 * state. Increment the usage count for all the devices in the dev_set
> +	 * before reset and decrement the same after reset.
> +	 */
> +	ret = vfio_pci_dev_set_pm_runtime_get(dev_set);
> +	if (ret)
> +		goto err_unlock;
> +
>  	list_for_each_entry(cur_vma, &dev_set->device_list, vdev.dev_set_list) {
>  		/*
>  		 * Test whether all the affected devices are contained by the
> @@ -2219,6 +2351,9 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  		else
>  			mutex_unlock(&cur->vma_lock);
>  	}
> +
> +	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list)
> +		pm_runtime_put(&cur->pdev->dev);
>  err_unlock:
>  	mutex_unlock(&dev_set->lock);
>  	return ret;
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index e96cc3081236..7ec81271bd05 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -125,6 +125,7 @@ struct vfio_pci_core_device {
>  	bool			nointx;
>  	bool			needs_pm_restore;
>  	bool			pm_intx_masked;
> +	bool			pm_runtime_engaged;
>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;

